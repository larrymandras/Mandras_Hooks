#!/usr/bin/env bash
# Hook: Stop / PostToolUseFailure → Send notification to Telegram
#
# Usage in settings.json:
#   "Stop": [{ "matcher": "*", "command": "~/Mandras_Hooks/notifications/telegram-notify.sh" }]
#
# Env: TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID

set -euo pipefail

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ] || [ -z "${TELEGRAM_CHAT_ID:-}" ]; then
  exit 0  # Silently skip if not configured
fi

PAYLOAD=$(cat)
EVENT_TYPE=$(echo "$PAYLOAD" | jq -r '.event_type // "unknown"')
SESSION_ID=$(echo "$PAYLOAD" | jq -r '.session_id // "unknown"')

case "$EVENT_TYPE" in
  Stop)
    MESSAGE="Claude Code session completed: $SESSION_ID"
    ;;
  PostToolUseFailure)
    TOOL=$(echo "$PAYLOAD" | jq -r '.tool_name // "unknown"')
    ERROR=$(echo "$PAYLOAD" | jq -r '.error // "unknown error"' | head -c 200)
    MESSAGE="Tool failure in $SESSION_ID: $TOOL — $ERROR"
    ;;
  *)
    MESSAGE="Claude Code event: $EVENT_TYPE ($SESSION_ID)"
    ;;
esac

curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="$TELEGRAM_CHAT_ID" \
  -d text="$MESSAGE" \
  -d parse_mode="Markdown" > /dev/null 2>&1 &
