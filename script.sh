#!/bin/bash

npm install -g wrangler

export KV_NAMESPACE_ID=$(wrangler kv:namespace list 2> >(tee stderr.log >&2) | node -pe "JSON.parse(fs.readFileSync('/dev/stdin').toString()).find(kv => kv.title.includes('KV_STATUS_PAGE')).id")


echo "[env.production]" >> wrangler.toml
echo "kv_namespaces = [{binding=\"KV_STATUS_PAGE\", id=\"${KV_NAMESPACE_ID}\"}]" >> wrangler.toml
[ -z "$SECRET_SLACK_WEBHOOK_URL" ] && echo "Secret SECRET_SLACK_WEBHOOK_URL not set, creating dummy one..." && SECRET_SLACK_WEBHOOK_URL="default-gh-action-secret" || true
[ -z "$SECRET_TELEGRAM_API_TOKEN" ] && echo "Secret SECRET_TELEGRAM_API_TOKEN not set, creating dummy one..." && SECRET_TELEGRAM_API_TOKEN="default-gh-action-secret" || true
[ -z "$SECRET_TELEGRAM_CHAT_ID" ] && echo "Secret SECRET_TELEGRAM_CHAT_ID not set, creating dummy one..." && SECRET_TELEGRAM_CHAT_ID="default-gh-action-secret" || true
[ -z "$SECRET_DISCORD_WEBHOOK_URL" ] && echo "Secret SECRET_DISCORD_WEBHOOK_URL not set, creating dummy one..." && SECRET_DISCORD_WEBHOOK_URL="default-gh-action-secret" || true
