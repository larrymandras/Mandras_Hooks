#!/usr/bin/env bash
# Hook: PostToolUse → Send telemetry to CodePulse ingest endpoint
#
# Usage in settings.json:
#   "PostToolUse": [{ "matcher": "*", "command": "~/Mandras_Hooks/telemetry/codepulse-ingest.sh" }]
#
# Reads from stdin: JSON with tool_name, session_id, etc.
# Env: CODEPULSE_INGEST_URL (defaults to local Convex dev)

set -euo pipefail

INGEST_URL="${CODEPULSE_INGEST_URL:-https://ideal-sandpiper-297.convex.site/ingest}"

# Read hook payload from stdin
PAYLOAD=$(cat)

# Extract fields
SESSION_ID=$(echo "$PAYLOAD" | jq -r '.session_id // "unknown"')
TOOL_NAME=$(echo "$PAYLOAD" | jq -r '.tool_name // "unknown"')
EVENT_TYPE=$(echo "$PAYLOAD" | jq -r '.event_type // "PostToolUse"')

# Send to CodePulse
curl -s -X POST "$INGEST_URL" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg sid "$SESSION_ID" \
    --arg tool "$TOOL_NAME" \
    --arg evt "$EVENT_TYPE" \
    --argjson payload "$PAYLOAD" \
    '{sessionId: $sid, toolName: $tool, eventType: $evt, payload: $payload, timestamp: (now | floor)}'
  )" > /dev/null 2>&1 &
