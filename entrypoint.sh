#!/usr/bin/env bash
set -a
source .env
set +a

API_URL="${HOST}/docs"
HOST_FRONTEND_ADMIN="${HOST_FRONTEND_ADMIN}"
SCHEME="$(echo "$DASHBOARD_NEXTAUTH_URL" | sed -E 's#(https?://).*#\1#')"
DOMAIN="$(echo "$DASHBOARD_NEXTAUTH_URL" | sed -E 's#https?://##')"
HOST_FRONTEND="${SCHEME}${ORG_SLUG}.${DOMAIN}"

clear
echo -e "\033[38;5;208m"
cat <<'EOF'
    _____  ____    ____    ______  ______   ____    ______
   / ___/ / __ \  /   |   / ____/ / ____/  / __ \  / ____/
  \__ \  / /_/ / / /| |  / /     / __/    / / / / / /_    
 ___/ / / ____/ / ___ | / /___  / /___   / /_/ / / __/    
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
echo -e "--------------------------------------------------"