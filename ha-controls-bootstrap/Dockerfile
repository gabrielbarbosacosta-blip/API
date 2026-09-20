FROM ghcr.io/home-assistant/home-assistant:stable
COPY entrypoint.sh /entrypoint-controls.sh
COPY scripts.yaml /tmp/scripts.yaml
RUN chmod +x /entrypoint-controls.sh
ENTRYPOINT ["/entrypoint-controls.sh"]
