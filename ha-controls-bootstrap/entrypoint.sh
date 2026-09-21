#!/bin/sh
set -eu

cp /tmp/scripts.yaml /config/scripts.yaml
cp /tmp/h50_dashboard.yaml /config/h50_dashboard.yaml

# Xiaomi Cloud Map Extractor v3 is isolated from xiaomi_home.
# Copy only this component; do not touch any other custom integration.
mkdir -p /config/custom_components
rm -rf /config/custom_components/xiaomi_cloud_map_extractor
cp -R /opt/xiaomi_cloud_map_extractor /config/custom_components/xiaomi_cloud_map_extractor

mkdir -p /config/packages
if [ -n "${ALEXA_WEBHOOK_ID:-}" ]; then
  sed "s/__ALEXA_WEBHOOK_ID__/${ALEXA_WEBHOOK_ID}/g" /tmp/alexa_robot.yaml > /config/packages/alexa_robot.yaml
fi

if ! grep -q '^script: !include scripts.yaml$' /config/configuration.yaml; then
  printf '\nscript: !include scripts.yaml\n' >> /config/configuration.yaml
fi

if ! grep -q '^[[:space:]]*packages: !include_dir_named packages$' /config/configuration.yaml; then
  if grep -q '^homeassistant:$' /config/configuration.yaml; then
    sed -i '/^homeassistant:$/a\  packages: !include_dir_named packages' /config/configuration.yaml
  else
    printf '\nhomeassistant:\n  packages: !include_dir_named packages\n' >> /config/configuration.yaml
  fi
fi

if ! grep -q '^lovelace:$' /config/configuration.yaml; then
  cat >> /config/configuration.yaml <<'YAML'

lovelace:
  mode: storage
  dashboards:
    h50-pro:
      mode: yaml
      title: H50 Pro
      icon: mdi:robot-vacuum
      show_in_sidebar: true
      filename: h50_dashboard.yaml
YAML
fi

exec /init
