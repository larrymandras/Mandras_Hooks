# Notification Hooks

Route Claude Code events to external messaging services.

## telegram-notify.sh

Sends session completion and tool failure alerts to Telegram.

**Environment variables:**
```bash
export TELEGRAM_BOT_TOKEN="your-bot-token"
export TELEGRAM_CHAT_ID="your-chat-id"
```

**Hook config:**
```json
"Stop": [{ "matcher": "*", "command": "~/Mandras_Hooks/notifications/telegram-notify.sh" }],
"PostToolUseFailure": [{ "matcher": "*", "command": "~/Mandras_Hooks/notifications/telegram-notify.sh" }]
```
