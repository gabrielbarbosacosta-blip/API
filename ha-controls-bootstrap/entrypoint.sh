#!/bin/sh
set -eu

cp /tmp/scripts.yaml /config/scripts.yaml

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

exec /init
