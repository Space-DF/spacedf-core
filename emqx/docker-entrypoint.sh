#!/bin/bash
set -e

EMQX_API="http://localhost:18083/api/v5"

create_user() {
  local user=$1 pass=$2 name=$3
  [[ -z "$user" || -z "$pass" ]] && return 0

  local code=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
    "${EMQX_API}/authentication/password_based%3Abuilt_in_database/users" \
    -H "Content-Type: application/json" -H "Authorization: Bearer ${TOKEN}" \
    -d "{\"user_id\":\"${user}\",\"password\":\"${pass}\"}")

  case "$code" in
    200|201) echo "Created ${name}: ${user}" ;;
    409)     echo "${name} already exists: ${user}" ;;
    *)       echo "Failed ${name} (HTTP $code): ${user}" ;;
  esac
}

init_users() {
  echo "Waiting for EMQX..."
  until /opt/emqx/bin/emqx ctl status 2>/dev/null | grep -q 'is started'; do sleep 2; done

  TOKEN=$(curl -s -X POST "${EMQX_API}/login" -H "Content-Type: application/json" \
    -d "{\"username\":\"${EMQX_DASHBOARD__DEFAULT_USERNAME}\",\"password\":\"${EMQX_DASHBOARD__DEFAULT_PASSWORD}\"}" \
    | grep -o '"token":"[^"]*"' | cut -d'"' -f4)

  [[ -z "$TOKEN" ]] && { echo "Failed to login to EMQX"; return 1; }

  echo "EMQX ready, creating users..."
  create_user "$MQTT_MPA_USERNAME" "$MQTT_MPA_PASSWORD" "MPA Service"
  create_user "$MQTT_BROKER_BRIDGE_USERNAME" "$MQTT_BROKER_BRIDGE_PASSWORD" "Broker Bridge"
  echo "User initialization complete"
}

init_users &
exec /opt/emqx/bin/emqx foreground
