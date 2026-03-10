# Git Hooks

Git workflow automation triggered by Claude Code events.

## auto-stage-on-write.sh

Automatically `git add` files after Claude writes or edits them.

**Hook config:**
```json
"PostToolUse": [{
  "matcher": "Write|Edit",
  "command": "~/Mandras_Hooks/git/auto-stage-on-write.sh"
}]
```
