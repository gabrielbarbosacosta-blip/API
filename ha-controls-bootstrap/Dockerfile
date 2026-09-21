FROM ghcr.io/home-assistant/home-assistant:stable
COPY entrypoint.sh /entrypoint-controls.sh
COPY scripts.yaml /tmp/scripts.yaml
COPY alexa_robot.yaml /tmp/alexa_robot.yaml
COPY h50_dashboard.yaml /tmp/h50_dashboard.yaml
RUN chmod +x /entrypoint-controls.sh
ENTRYPOINT ["/entrypoint-controls.sh"]
