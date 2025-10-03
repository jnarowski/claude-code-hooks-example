# Claude Code Hooks Example

Example project demonstrating Claude Code hooks with macOS notifications via `terminal-notifier`.

## Features

- ✅ All 9 Claude Code hooks implemented with proper JSON parsing
- 📝 Timestamped logging to `.claude/hooks.log`
- 🔔 macOS native notifications with hook context data
- 🎯 Demonstrates parsing stdin JSON data in hooks using `jq`

## Prerequisites

Install dependencies via Homebrew:

```bash
brew install terminal-notifier jq
```

## Usage

1. Open this project in Claude Code
2. Hooks will automatically fire during your session
3. Monitor logs: `tail -f .claude/hooks.log`
4. macOS notifications will appear for each hook event with parsed data

## Hooks Implemented

All hooks parse JSON data from stdin to extract contextual information:

- **PreToolUse** - Before tool execution (extracts `tool_name`, `session_id`)
- **PostToolUse** - After tool execution (extracts `tool_name`, `success`, `session_id`)
- **UserPromptSubmit** - When user submits prompt (extracts first 50 chars of `prompt`)
- **SessionStart** - Session begins with sound (extracts `session_id`, `cwd`)
- **SessionEnd** - Session ends with sound (extracts `session_id`, `cwd`)
- **Stop** - Agent stops responding (extracts `session_id`, `cwd`)
- **SubagentStop** - Subagent completes (extracts `session_id`)
- **PreCompact** - Before context compaction (extracts `session_id`, `cwd`)
- **Notification** - Claude notifications (extracts `message`, `session_id`)

## How It Works

Claude Code sends JSON data to hooks via stdin. Each hook:

1. Captures stdin: `input=$(cat)`
2. Parses JSON with jq: `session_id=$(echo "$input" | jq -r '.session_id')`
3. Uses extracted data in logging and notifications

Example hook command:
```bash
input=$(cat) && session_id=$(echo "$input" | jq -r '.session_id') && tool_name=$(echo "$input" | jq -r '.tool_name') && echo "[$(date '+%Y-%m-%d %H:%M:%S')] PreToolUse - Tool: $tool_name, Session: $session_id" >> .claude/hooks.log && terminal-notifier -title 'PreToolUse' -subtitle "Tool: $tool_name" -message "Session: $session_id"
```

## Configuration

See `.claude/settings.json` for complete hook configuration. Each hook demonstrates proper JSON parsing patterns that can be adapted for custom hook implementations.

### Permissions

The `.claude/settings.json` file configures auto-approved permissions for common operations including `mkdir`, `uv`, `find`, `mv`, `grep`, `npm`, `ls`, `cp`, `chmod`, `touch`, `Write`, and `Edit` tools.

### Status Line

A custom status line is configured using: `echo 'Status Line Hook'`

### Notification Grouping

Some hooks use notification grouping to prevent spam:

- `UserPromptSubmit` uses group "prompt" to replace previous notifications
- `PreCompact` uses group "compact"

## File Structure

```text
.claude/
├── settings.json          # Hook configuration and permissions
├── hooks.log             # Timestamped hook activity log
└── hooks/
    ├── pre-tool-use.sh
    ├── post-tool-use.sh
    ├── user-prompt-submit.sh
    ├── session-start.sh
    ├── session-end.sh
    ├── stop.sh
    ├── subagent-stop.sh
    ├── pre-compact.sh
    └── notification.sh
```
