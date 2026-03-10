# Session Hooks

Session lifecycle management — logging, cleanup, and summaries.

## session-summary.sh

Logs session end events to `~/.claude/session-logs/` with full payload.

**Hook config:**
```json
"Stop": [{
  "matcher": "*",
  "command": "~/Mandras_Hooks/session/session-summary.sh"
}]
```
