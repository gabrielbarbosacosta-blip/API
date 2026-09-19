FROM ghcr.io/home-assistant/home-assistant:stable
COPY entrypoint.sh /entrypoint-cloud.sh
RUN chmod +x /entrypoint-cloud.sh
ENTRYPOINT ["/entrypoint-cloud.sh"]
