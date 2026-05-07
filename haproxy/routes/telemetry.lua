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
  ["^/api/telemetry/v1/geofences/test/?$"] = {
    POST = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/geofences/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/geofences/[0-9a-f-]+/?$"] = {
    PUT = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/events/device/[0-9a-f-]+/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/automations/summary/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/automations/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "telemetry",
      auth_required = true,
      space_required = true,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/automations/[0-9a-f-]+/?$"] = {
    PUT = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/actions/?$"] = {
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    POST = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/actions/[0-9a-f-]+/?$"] = {
    PUT = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    GET = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    PATCH = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
    DELETE = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
  ["^/api/telemetry/v1/notifications/subscribe/?$"] = {
    POST = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    }
  },
  ["^/api/telemetry/v1/notifications/subscribe/[0-9a-f-]+/?$"] = {
    DELETE = {
      service = "telemetry",
      auth_required = true,
      space_required = false,
      organization_required = false,
      is_root_user_api = false,
    },
  },
}

return routes
