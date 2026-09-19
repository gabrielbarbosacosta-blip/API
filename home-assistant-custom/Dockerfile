FROM alpine:3.22 AS xiaomi
ARG XIAOMI_HOME_VERSION=v0.4.7
RUN apk add --no-cache ca-certificates wget tar \
 && wget -qO- "https://github.com/XiaoMi/ha_xiaomi_home/archive/refs/tags/${XIAOMI_HOME_VERSION}.tar.gz" \
 | tar -xz -C /tmp \
 && mkdir -p /opt/xiaomi_home \
 && cp -a "/tmp/ha_xiaomi_home-${XIAOMI_HOME_VERSION#v}/custom_components/xiaomi_home/." /opt/xiaomi_home/

FROM ghcr.io/home-assistant/home-assistant:stable
COPY --from=xiaomi /opt/xiaomi_home /opt/xiaomi_home
COPY entrypoint.sh /entrypoint-custom.sh
RUN chmod +x /entrypoint-custom.sh
ENTRYPOINT ["/entrypoint-custom.sh"]
