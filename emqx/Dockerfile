FROM emqx/emqx:5.7.1

USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /opt/emqx/docker-entrypoint.sh
RUN chmod +x /opt/emqx/docker-entrypoint.sh && chown emqx:emqx /opt/emqx/docker-entrypoint.sh

USER emqx

ENTRYPOINT ["/opt/emqx/docker-entrypoint.sh"]