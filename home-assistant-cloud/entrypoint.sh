#!/bin/sh
set -eu

mkdir -p /config

if [ ! -f /config/configuration.yaml ]; then
  cat > /config/configuration.yaml <<'EOF'
default_config:

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 100.64.0.0/10
EOF
elif ! grep -q '^http:' /config/configuration.yaml; then
  cat >> /config/configuration.yaml <<'EOF'

http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 100.64.0.0/10
EOF
fi

exec /init
