#!/bin/sh
set -eu

if ! grep -q '^alexa:' /config/configuration.yaml; then
  cat >> /config/configuration.yaml <<'EOF'

alexa:
  smart_home:
    locale: pt-BR
EOF
fi

exec /init
