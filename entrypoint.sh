#!/usr/bin/env bash

# Check if .env file exists
if [ ! -f .env ]; then
  echo -e "\033[1;31mERROR: .env file not found!\033[0m"
  echo -e "\033[0;33mYou can copy from .env.example if available:\033[0m"
  echo -e "  cp .env.example .env"
  exit 1
fi

set -a
source .env
set +a

API_URL="${HOST}/docs"
HOST_FRONTEND_ADMIN="${HOST_FRONTEND_ADMIN}"
SCHEME="$(echo "$DASHBOARD_NEXTAUTH_URL" | sed -E 's#(https?://).*#\1#')"
DOMAIN="$(echo "$DASHBOARD_NEXTAUTH_URL" | sed -E 's#https?://##')"
HOST_FRONTEND="${SCHEME}spacedf.${DOMAIN}"

clear
echo -e "\033[38;5;208m"
cat <<'EOF'
    _____  ____    ____    ______  ______   ____    ______
   / ___/ / __ \  /   |   / ____/ / ____/  / __ \  / ____/
  \__ \  / /_/ / / /| |  / /     / __/    / / / / / /_    
 ___/ / / ____/ / /_| | / /___  / /___   / /_/ / / __/    
/____/ /_/     /_/  |_| \____/  \____/  /_____/ /_/                     
EOF
echo -e "\033[0m"
echo -e "\033[1;36mSpaceDF Core\033[0m"
echo -e "\033[0;36mCloud Native Platform\033[0m"
echo -e "Version: 0.0.1"
echo

# ===== Build & Start =====
COMPOSE_FILE="./docker-compose.yml"
PROJECT_NAME="spacedf-core"
USERNAME_CHANGED=false
PASSWORD_CHANGED=false

if docker ps --format '{{.Names}}' | grep -q "^rabbitmq$"; then
  EXISTING_USER=$(docker exec rabbitmq rabbitmqctl list_users --formatter json 2>/dev/null | grep -o '"user":"[^"]*"' | head -1 | cut -d'"' -f4)
  
  if [ -n "$EXISTING_USER" ] && [ "$EXISTING_USER" != "$RABBITMQ_DEFAULT_USER" ]; then
    USERNAME_CHANGED=true
  fi
  
  if [ -n "$EXISTING_USER" ] && ! docker exec rabbitmq rabbitmqctl authenticate_user "$EXISTING_USER" "$RABBITMQ_DEFAULT_PASS" &>/dev/null; then
    PASSWORD_CHANGED=true
  fi
fi

# If username changed → create new account and delete old
if [ "$USERNAME_CHANGED" = true ]; then
  docker exec rabbitmq rabbitmqctl add_user "$RABBITMQ_DEFAULT_USER" "$RABBITMQ_DEFAULT_PASS"
  docker exec rabbitmq rabbitmqctl set_user_tags "$RABBITMQ_DEFAULT_USER" administrator
  docker exec rabbitmq rabbitmqctl set_permissions -p / "$RABBITMQ_DEFAULT_USER" ".*" ".*" ".*"
  docker exec rabbitmq rabbitmqctl delete_user "$EXISTING_USER"
fi

# Update password automatically
if [ "$PASSWORD_CHANGED" = true ]; then
  docker exec rabbitmq rabbitmqctl change_password "$RABBITMQ_DEFAULT_USER" "$RABBITMQ_DEFAULT_PASS"
fi

sync_postgres_password() {
  local container_name=$1
  local new_password=$2
  local db_user=${3:-postgres}
  
  if docker ps --format '{{.Names}}' | grep -q "^${container_name}$"; then
    for i in {1..10}; do
      if docker exec "$container_name" pg_isready -U "$db_user" &>/dev/null; then
        break
      fi
      sleep 1
    done

    docker exec "$container_name" psql -U "$db_user" -c "ALTER USER ${db_user} WITH PASSWORD '${new_password}';" &>/dev/null || true
  fi
}

# Sync all PostgreSQL passwords from .env BEFORE stopping
sync_postgres_password "device_postgres" "$DEVICE_POSTGRES_PASSWORD"
sync_postgres_password "auth_postgres" "$AUTH_POSTGRES_PASSWORD"
sync_postgres_password "dashboard_postgres" "$DASHBOARD_POSTGRES_PASSWORD"
sync_postgres_password "bootstrap_postgres" "$BOOTSTRAP_POSTGRES_PASSWORD"
sync_postgres_password "timescaledb" "$TIMESCALEDB_PASSWORD"

echo "Deploying SpaceDF Core..."
echo "Stopping existing services (if running)..."
docker compose -f "${COMPOSE_FILE}" -p "${PROJECT_NAME}" stop || true
echo "Building images & starting services..."
docker compose -f "${COMPOSE_FILE}" -p "${PROJECT_NAME}" up -d --build --remove-orphans
sleep 10

# ===== Success Message =====
echo
echo -e "--------------------------------------------------"
echo -e "SpaceDF Core started successfully"
echo "🌐 Frontend Admin     : ${HOST_FRONTEND_ADMIN}"
echo "🌐 Frontend Dashboard : ${HOST_FRONTEND}"
echo "🔗 Backend API        : ${API_URL}"