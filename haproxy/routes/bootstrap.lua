routes = {
  -- --------------
  -- Bootstrap
  -- --------------
  ["^/api/bootstrap/auth/login/?$"] = {
    POST = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
  },
  ["^/static/images/.*$"] = {
    GET = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/bootstrap/auth/send%-email%-confirm/?$"] = {
    POST = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/bootstrap/auth/forget%-password/?$"] = {
    POST = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/bootstrap/user/me/?$"] = {
    GET = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
    PUT = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
    PATCH = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
  },
  ["^/api/bootstrap/auth/register/?$"] = {
    POST = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
  },
  ["^/api/organizations/check/.*$"] = {
    GET = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/bootstrap/auth/refresh%-token/?$"] = {
    POST = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
  },
  ["^/api/bootstrap/auth/tokens/?$"] = {
    GET = {
      service = "bootstrap",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
  },
  -- --------------
  -- Organizations
  -- --------------
  ["^/api/organizations/?$"] = {
    GET = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = true,
    },
  },
  ["^/api/bootstrap/auth/change%-password/?$"] = {
    PUT = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/bootstrap/presigned%-url/?$"] = {
    GET = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/bootstrap/presigned%-url/.*$"] = {
    GET = {
      service = "bootstrap",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
}

return routes
