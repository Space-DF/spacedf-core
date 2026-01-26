routes = {
  -- --------------
  -- Telemetry
  -- --------------
  ["^/api/telemetry/v1/entities/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/alerts/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
}

return routes
