routes = {
  -- --------------
  -- Transformer
  -- --------------
  ["^/api/device%-models/?$"] = {
        GET = {
          service = "transformer",
          auth_required = true,
          role_required = nil,
          space_required = false,
          organization_required = true,
          is_root_user_api = true,
        },
      },
}

return routes
