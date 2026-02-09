routes = {
  -- --------------
  -- Auth
  -- --------------
  ["^/api/auth/login/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/send%-otp/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/send%-email%-confirm/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/google/login/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/change%-password/?$"] = {
    PUT = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/forget%-password/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/users/me/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    PUT = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/presigned%-url/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/presigned%-url/.*$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/oauth2/google/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/oauth2/spacedf%-console/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/register/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/refresh%-token/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/auth/spaces/switch/?$"] = {
    POST = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/spaces/invitation/?$"] = {
    POST = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/join%-space/.*$"] = {
    GET = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/spaces/join%-space/.*$"] = {
    GET = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/credentials/?$"] = {
    GET = {
      service = "auth",
      auth_required = false,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  -- --------------
  -- Space
  -- --------------
  ["^/api/spaces/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    PUT = {
      service = "auth",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "auth",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  -- --------------
  -- Space Roles & Policies
  -- --------------
  ["^/api/space%-policies/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/space%-policies/[0-9a-f-]+/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = nil,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/space%-role%-users/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/space%-role%-users/.*$"] = {
    POST = {
      service = "auth",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/space%-role%-users/[0-9a-f-]+/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PUT = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/space%-roles/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/space%-roles/[0-9a-f-]+/?$"] = {
    GET = {
      service = "auth",
      auth_required = true,
      role_required = "Viewer",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PUT = {
      service = "auth",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "auth",
      auth_required = true,
      role_required = "Editor",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "auth",
      auth_required = true,
      role_required = "Admin",
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
}

return routes
