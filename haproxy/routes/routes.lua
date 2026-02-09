docs_routes = require("routes.docs")
auth_routes = require("routes.auth")
dashboard_routes = require("routes.dashboard")
device_routes = require("routes.device")
mpa_routes = require("routes.mpa")
telemetry_routes = require("routes.telemetry")
bootstrap_routes = require("routes.bootstrap")

routes = {}
for k, v in pairs(docs_routes) do routes[k] = v end
for k, v in pairs(auth_routes) do routes[k] = v end
for k, v in pairs(dashboard_routes) do routes[k] = v end
for k, v in pairs(device_routes) do routes[k] = v end
for k, v in pairs(mpa_routes) do routes[k] = v end
for k, v in pairs(telemetry_routes) do routes[k] = v end
for k, v in pairs(bootstrap_routes) do routes[k] = v end

return routes
