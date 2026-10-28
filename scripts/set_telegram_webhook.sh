#!/usr/bin/env bash
set -euo pipefail

: "${TELEGRAM_BOT_TOKEN:?Set TELEGRAM_BOT_TOKEN}"
: "${PUBLIC_TELEGRAM_WEBHOOK_URL:?Set PUBLIC_TELEGRAM_WEBHOOK_URL}"
: "${WEBHOOK_SECRET:?Set WEBHOOK_SECRET}"

curl -sS -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/setWebhook" \
  -H "Content-Type: application/json" \
  -d "{
    \"url\": \"${PUBLIC_TELEGRAM_WEBHOOK_URL}\",
    \"secret_token\": \"${WEBHOOK_SECRET}\",
    \"allowed_updates\": [\"message\", \"callback_query\"]
  }"
