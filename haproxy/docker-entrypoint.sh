#!/bin/sh
set -e

echo "$JWT_PUBLIC_KEY" > /usr/local/etc/haproxy/pubkey.pem
exec haproxy -W -db -f /usr/local/etc/haproxy/haproxy.cfg