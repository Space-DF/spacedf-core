#!/bin/bash
set -e
[ -f .env ] || { echo "Error: .env not found"; exit 1; }
mkdir -p ./keys
openssl genrsa -out ./keys/private_key.pem 2048 2>/dev/null
openssl rsa -in ./keys/private_key.pem -pubout -out ./keys/public_key.pem 2>/dev/null
P=$(cat ./keys/private_key.pem | sed 's/$/\\n/' | tr -d '\n' | sed 's/\\n$//')
U=$(cat ./keys/public_key.pem | sed 's/$/\\n/' | tr -d '\n' | sed 's/\\n$//')
export P U PS=$(openssl rand -base64 32) DS=$(openssl rand -base64 32) RP=$(openssl rand -base64 16) OP=$(openssl rand -base64 16) BSK=$(openssl rand -base64 32) DSK=$(openssl rand -base64 32) DBSK=$(openssl rand -base64 32)
python3 << 'EOF'
import os, re

c = open('.env').read()
c = re.sub(r'^JWT_PRIVATE_KEY=.*$', '', c, flags=re.M)
c = re.sub(r'^JWT_PUBLIC_KEY=.*$', '', c, flags=re.M)
c = re.sub(
    r'(# Authentication JWT\n)',
    f'\\1JWT_PRIVATE_KEY="{os.environ["P"]}"\nJWT_PUBLIC_KEY="{os.environ["U"]}"\n',
    c
)

env_vars = {
    'RABBITMQ_DEFAULT_USER': 'default',
    'AUTH_POSTGRES_PASSWORD': 'postgres',
    'REDIS_HOST': 'redis://redis:6379/1',
    'DASHBOARD_POSTGRES_PASSWORD': 'postgres',
    'DEVICE_POSTGRES_PASSWORD': 'postgres',
    'BOOTSTRAP_POSTGRES_PASSWORD': 'postgres',
    'TIMESCALEDB_PASSWORD': 'postgres',
    'EMQX_USERNAME': 'user',
    'EMQX_PASSWORD': 'password123',
    'MQTT_BROKER_BRIDGE_PASSWORD': 'Default@1234',
    'MQTT_PASSWORD': 'Default@1234',
    'ORG_NAME': 'Default Organization',
    'OWNER_EMAIL': 'admin@example.com',
    'OWNER_PASSWORD': 'changeme@Default123',
    'BOOTSTRAP_SECRET_KEY': os.environ['BSK'],
    'AUTH_SECRET_KEY': os.environ['BSK'],
    'DEVICE_SECRET_KEY': os.environ['DSK'],
    'DASHBOARD_SECRET_KEY': os.environ['DBSK'],
    'DASHBOARD_MQTT_USERNAME': 'anonymous',
    'DASHBOARD_MQTT_PASSWORD': 'password123',
    'RABBITMQ_DEFAULT_PASS': 'password',
    'PORTAL_NEXTAUTH_SECRET': os.environ['PS'],
    'DASHBOARD_NEXTAUTH_SECRET': os.environ['DS']
}

for key, value in env_vars.items():
    if f'{key}=' in c:
        c = re.sub(f'^{key}=.*$', f'{key}="{value}"', c, flags=re.M)
    else:
        c += f'\n{key}="{value}"'
with open('.env', 'w') as f:
    f.write(c)
EOF
rm -rf ./keys
echo "✓ Done"
