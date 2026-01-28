#!/usr/bin/env bash
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