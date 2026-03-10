# Telemetry Hooks

Hooks that send event data to CodePulse and other monitoring systems.

## codepulse-ingest.sh

Sends PostToolUse events to the CodePulse Convex ingest endpoint.

**Setup:**
```bash
export CODEPULSE_INGEST_URL="https://ideal-sandpiper-297.convex.site/ingest"
```

**Hook config:**
```json
"PostToolUse": [{
  "matcher": "*",
  "command": "~/Mandras_Hooks/telemetry/codepulse-ingest.sh"
}]
```
