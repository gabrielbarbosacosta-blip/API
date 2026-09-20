#!/bin/sh
set -eu

cp /tmp/scripts.yaml /config/scripts.yaml

if ! grep -q '^script: !include scripts.yaml$' /config/configuration.yaml; then
  printf '\nscript: !include scripts.yaml\n' >> /config/configuration.yaml
fi

exec /init
