local routes = require('routes.routes')
local cjson = require("cjson")
local mime = require("mime")
local redis = require('redis')

local ROLE_HIERARCHY = { Viewer = 1, Editor = 2, Admin = 3, Owner = 4}

local function redis_get(key)
  local red, err = redis.connect("redis", 6379)
  if not red then
    return nil
  end

  red:select(1)

  local ok, result = pcall(function()
    return red:get(key)
  end)

  pcall(function()
    red:quit()
  end)

  if not ok then
    return nil
  end

  return result
end

function get_route(txn)
  local path = txn.sf:path()
  local method = txn.sf:method()

  for route, methods in pairs(routes) do
    if string.match(path, route) then
      local api_info = methods[method]
      if api_info then
        return route
      end
    end
  end
  return "not_found"
end

local function get_route_info(txn, key, default)
  local route = txn:get_var("txn.route")
  if not route or route == "not_found" then
    return default
  end
  return routes[route][txn.sf:method()][key]
end

function get_service(txn)
  return get_route_info(txn, "service", "not_found")
end

function get_auth_required(txn)
  return get_route_info(txn, "auth_required", false)
end

local function validate_entity(txn, entity_name)
  local entity_required = get_route_info(txn, entity_name .. "_required", false)
  if entity_required then
    local entity = txn:get_var("txn." .. entity_name)
    if not entity then
      return false
    end

    txn.http:req_set_header("x-" .. entity_name, entity)
  end
  
  return true
end

function validate_space(txn)
  return validate_entity(txn, "space")
end

function validate_organization(txn)
  return validate_entity(txn, "organization")
end

function check_change_roles(txn)
  local space_required = get_route_info(txn, "space_required")
  local org_required = get_route_info(txn, "organization_required")
  if not space_required and not org_required then
    return true
  end
  if space_required then
    local space_roles = redis_get(":1:space_roles_" .. txn:get_var("txn.user_id"))
    if not space_roles then
      return false
    end
    return true
  end

  local org_roles = redis_get(":1:organization_roles_" .. txn:get_var("txn.user_id"))
  if not org_roles then
    return false
  end
  return true
end

function check_scope_roles(roles_json, data, required_role)
  local status, roles_table = pcall(cjson.decode, roles_json)
  if not status or not roles_table then
    return false
  end

  local user_role = roles_table[data]
  if not user_role then
    return false
  end
  local user_rank = ROLE_HIERARCHY[user_role]
  local required_rank = ROLE_HIERARCHY[required_role]

  if not user_rank or not required_rank then
    return false
  end

  if user_rank >= required_rank then
    return true
  end
  return false
end

function check_roles(txn)
  local required_roles = get_route_info(txn, "role_required", nil)
  local check_roles_org = get_route_info(txn, "organization_required", nil)
  local check_roles_space = get_route_info(txn, "space_required", nil)

  if not required_roles then
    return true
  end

  if check_roles_space then
    local roles_json = txn:get_var("txn.space_roles")
    local space = txn:get_var("txn.space")
    local result = check_scope_roles(roles_json, space, required_roles)
    if result ~= false then return result end
  end

  if check_roles_org then
    local roles_json = txn:get_var("txn.organization_roles")
    local org = txn:get_var("txn.organization")
    local result = check_scope_roles(roles_json, org, required_roles)
    if result ~= false then return result end
  end
  return false
end

function validate_issuer(txn)
  local token_issuer = txn:get_var("txn.iss")
  if not token_issuer then
    return false
  end

  local is_root_user_api = get_route_info(txn, "is_root_user_api", false)
  if is_root_user_api then
    local host = os.getenv("HOST")
    if not host then
      return false
    end

    return token_issuer == host
  end

  if token_issuer:match("^https?://([^/]+)") then
    return true
  end
  
  return false
end

local function split_jwt(token)
  local parts = {}
  for part in string.gmatch(token, "[^.]+") do
    table.insert(parts, part)
  end
  return parts[1], parts[2], parts[3]
end

local function decode_jwt_payload(jwt)
  local _, payload_b64, _ = split_jwt(jwt)
  if not payload_b64 then
    return nil
  end

  local b64 = payload_b64:gsub('-', '+'):gsub('_', '/')
  local pad = #b64 % 4
  if pad > 0 then b64 = b64 .. string.rep("=", 4 - pad) end
  local decoded_json = mime.unb64(b64)
  if not decoded_json then
    return nil
  end

  local ok, result = pcall(cjson.decode, decoded_json)
  if not ok then
    return nil
  end
  return result
end

function decode_jwt(txn)
  local auth_header = txn.sf:req_hdr("Authorization")
  if not auth_header then return end
  local jwt = auth_header:gsub("Bearer ", "")
  local payload = decode_jwt_payload(jwt)
  if payload and payload["space_roles"] then
    txn:set_var("txn.space_roles", cjson.encode(payload["space_roles"]))
  end
  if payload and payload["organization_roles"] then
    txn:set_var("txn.organization_roles", cjson.encode(payload["organization_roles"]))
  end
end

local function split_jwt(token)
  local parts = {}
  for part in string.gmatch(token, "[^.]+") do
    table.insert(parts, part)
  end
  return parts[1], parts[2], parts[3]
end

local function decode_jwt_payload(jwt)
  local _, payload_b64, _ = split_jwt(jwt)
  if not payload_b64 then
    return nil
  end

  local b64 = payload_b64:gsub('-', '+'):gsub('_', '/')
  local pad = #b64 % 4
  if pad > 0 then b64 = b64 .. string.rep("=", 4 - pad) end
  local decoded_json = mime.unb64(b64)
  if not decoded_json then
    return nil
  end

  local ok, result = pcall(cjson.decode, decoded_json)
  if not ok then
    return nil
  end
  return result
end

function decode_jwt(txn)
  local auth_header = txn.sf:req_hdr("Authorization")
  if not auth_header then return end
  local jwt = auth_header:gsub("Bearer ", "")
  local payload = decode_jwt_payload(jwt)
  if payload and payload["space_roles"] then
    txn:set_var("txn.space_roles", cjson.encode(payload["space_roles"]))
  end
  if payload and payload["organization_roles"] then
    txn:set_var("txn.organization_roles", cjson.encode(payload["organization_roles"]))
  end
end

core.register_fetches("get_route", get_route)
core.register_fetches("get_service", get_service)
core.register_fetches("get_auth_required", get_auth_required)
core.register_fetches("check_change_roles", check_change_roles)
core.register_fetches("check_roles", check_roles)
core.register_fetches("validate_space", validate_space)
core.register_fetches("validate_organization", validate_organization)
core.register_fetches("validate_issuer", validate_issuer)
core.register_action("decode_jwt", { "http-req" }, decode_jwt)