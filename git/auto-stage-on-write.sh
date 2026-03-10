#!/usr/bin/env bash
# Hook: PostToolUse → Auto git-add files after Write/Edit
#
# Usage in settings.json:
#   "PostToolUse": [{ "matcher": "Write|Edit", "command": "~/Mandras_Hooks/git/auto-stage-on-write.sh" }]

set -euo pipefail

PAYLOAD=$(cat)
FILE_PATH=$(echo "$PAYLOAD" | jq -r '.tool_input.file_path // .tool_input.path // ""')

if [ -n "$FILE_PATH" ] && [ -f "$FILE_PATH" ]; then
  # Only stage if we're inside a git repo
  if git -C "$(dirname "$FILE_PATH")" rev-parse --git-dir > /dev/null 2>&1; then
    git -C "$(dirname "$FILE_PATH")" add "$FILE_PATH" 2>/dev/null || true
  fi
fi

exit 0
