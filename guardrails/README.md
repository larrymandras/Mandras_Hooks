# Guardrail Hooks

Safety checks that run before tool execution to prevent dangerous operations.

## block-dangerous-commands.sh

Blocks known-dangerous shell commands (rm -rf /, fork bombs, disk wipes, etc.).

**Hook config:**
```json
"PreToolUse": [{
  "matcher": "Bash",
  "command": "~/Mandras_Hooks/guardrails/block-dangerous-commands.sh"
}]
```

Exit codes:
- `0` — Allow the command
- `2` — Block the command (prints reason to stderr)
