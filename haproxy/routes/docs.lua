routes = {
  -- --------------
  -- API documentation
  -- --------------
  ["^/docs.*$"] = {
    GET = {
      service = "docs",
      auth_required = false,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/openapi.json$"] = {
    GET = {
      service = "docs",
      auth_required = false,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
}

return routes
