#!/usr/bin/env bash
# Hook: PreToolUse → Block dangerous shell commands
#
# Usage in settings.json:
#   "PreToolUse": [{ "matcher": "Bash", "command": "~/Mandras_Hooks/guardrails/block-dangerous-commands.sh" }]
#
# Exit 0 = allow, Exit 2 = block

set -euo pipefail

PAYLOAD=$(cat)
COMMAND=$(echo "$PAYLOAD" | jq -r '.tool_input.command // ""')

# Patterns to block
BLOCKED_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \$HOME"
  ":(){ :|:& };:"
  "mkfs\."
  "dd if=/dev/zero of=/dev/sd"
  "> /dev/sda"
  "chmod -R 777 /"
  "curl.*| bash"
  "wget.*| bash"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    echo "BLOCKED: Command matches dangerous pattern: $pattern" >&2
    exit 2
  fi
done

exit 0
