routes = {
  -- --------------
  -- Dashboard
  -- --------------
  ["^/api/dashboards/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "dashboard",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/dashboards/[0-9a-f-]+/widgets/bulk%-create/?$"] = {
    POST = {
      service = "dashboard",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/dashboards/[0-9a-f-]+/widgets/bulk%-update/?$"] = {
    PUT = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/dashboards/[0-9a-f-]+/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PUT = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "dashboard",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  -- --------------
  -- Widgets
  -- --------------
  ["^/api/dashboards/[0-9a-f-]+/widgets/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/dashboards/[0-9a-f-]+/widgets/[0-9a-f-]+/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PUT = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "dashboard",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  -- --------------
  -- Device states
  -- --------------
  ["^/api/device%-states/daily/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/device%-states/hourly/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/device%-states/minutely/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/device%-states/monthly/?$"] = {
    GET = {
      service = "dashboard",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
}

return routes
