FROM haproxy:3.1.5

USER root

# Install Lua dependencies
RUN apt-get update && apt-get install -y lua5.4 lua-cjson lua-socket git \
    && rm -rf /var/lib/apt/lists/*

# Install redis-lua
RUN mkdir -p /usr/local/share/lua/5.4/ && \
    git clone https://github.com/nrk/redis-lua.git /tmp/redis-lua && \
    mv /tmp/redis-lua/src/redis.lua /usr/local/share/lua/5.4/redis.lua && \
    rm -rf /tmp/redis-lua

# Copy config and scripts
COPY haproxy/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy/handlers /usr/local/etc/haproxy/handlers
COPY haproxy/routes /usr/local/share/lua/5.4/routes

# Copy entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN chown -R haproxy:haproxy /usr/local/etc/haproxy

# Run the production server
ENTRYPOINT ["/docker-entrypoint.sh"]

USER haproxy