# Mandras_Hooks

Claude Code hooks — lifecycle event handlers shared across all Claude Code and Claude Desktop instances.

## What Are Hooks?

Hooks are shell commands that run automatically in response to Claude Code lifecycle events. They enable automation, telemetry, guardrails, and custom workflows.

## Hook Events

| Event | When It Fires | Use Cases |
|-------|--------------|----------|
| `PreToolUse` | Before a tool executes | Block dangerous commands, log intent |
| `PostToolUse` | After a tool succeeds | Record telemetry, trigger follow-ups |
| `PostToolUseFailure` | After a tool fails | Alert on errors, retry logic |
| `PermissionRequest` | When tool needs approval | Auto-approve safe tools, audit decisions |
| `SubagentStart` | When a subagent spawns | Track agent tree, resource limits |
| `SubagentStop` | When a subagent completes | Collect results, cleanup |
| `Stop` | Session ends | Summarize work, push telemetry |
| `UserPromptSubmit` | User sends a message | Input validation, logging |
| `PreCompact` | Before context compaction | Save important context |
| `InstructionsLoaded` | CLAUDE.md files loaded | Track config changes |
| `ConfigChange` | Settings modified | Drift detection |
| `WorktreeCreate` | Git worktree created | Track parallel work |
| `WorktreeRemove` | Git worktree removed | Cleanup resources |
| `Notification` | Claude sends notification | Route to Telegram/Slack |

## Directory Structure

```
hooks/
├── telemetry/          # Event logging and CodePulse integration
├── guardrails/         # Safety checks and permission automation
├── notifications/      # Route alerts to Telegram, Slack, Email
├── git/                # Git workflow automation
├── session/            # Session lifecycle management
└── codepulse/          # CodePulse dashboard integration hooks
```

## Installation

Add hooks to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "*",
        "command": "path/to/hook-script.sh"
      }
    ]
  }
}
```

Or clone this repo and symlink:

```bash
git clone https://github.com/larrymandras/Mandras_Hooks.git ~/Mandras_Hooks
```

## Related Repos

- [Mandras_Skills](https://github.com/larrymandras/Mandras_Skills) — Slash commands
- [Mandras_MCP_Servers](https://github.com/larrymandras/Mandras_MCP_Servers) — MCP server configs
- [Mandras_Templates](https://github.com/larrymandras/Mandras_Templates) — CLAUDE.md & project templates
