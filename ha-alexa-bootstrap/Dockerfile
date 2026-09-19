FROM ghcr.io/home-assistant/home-assistant:stable
COPY entrypoint.sh /entrypoint-alexa.sh
RUN chmod +x /entrypoint-alexa.sh
ENTRYPOINT ["/entrypoint-alexa.sh"]
