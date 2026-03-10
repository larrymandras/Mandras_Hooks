#!/usr/bin/env bash
# Hook: Stop → Log session summary to a local file
#
# Usage in settings.json:
#   "Stop": [{ "matcher": "*", "command": "~/Mandras_Hooks/session/session-summary.sh" }]

set -euo pipefail

LOG_DIR="${HOME}/.claude/session-logs"
mkdir -p "$LOG_DIR"

PAYLOAD=$(cat)
SESSION_ID=$(echo "$PAYLOAD" | jq -r '.session_id // "unknown"')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "[$TIMESTAMP] Session ended: $SESSION_ID" >> "$LOG_DIR/sessions.log"
echo "$PAYLOAD" | jq '.' >> "$LOG_DIR/${SESSION_ID}.json" 2>/dev/null || true

exit 0
