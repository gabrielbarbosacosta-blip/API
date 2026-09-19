#!/bin/sh
set -eu

mkdir -p /config/custom_components
rm -rf /config/custom_components/xiaomi_home
cp -a /opt/xiaomi_home /config/custom_components/xiaomi_home

if ! grep -q '^http:' /config/configuration.yaml 2>/dev/null; then
  cat >> /config/configuration.yaml <<'EOF'

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 100.64.0.0/10
EOF
fi

exec /init
