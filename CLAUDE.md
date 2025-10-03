# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a demonstration repository for Claude Code hooks functionality. All 9 hook types are implemented in `.claude/hooks/` with macOS native notifications and logging.

### How Hooks Receive Data

**Important**: Hooks do NOT use environment variables like `${HOOK_SESSION_ID}`. Instead, Claude Code sends JSON data to hooks via stdin.

Each hook receives a JSON object with fields like:
- `session_id` - Unique session identifier
- `cwd` - Current working directory
- `transcript_path` - Path to conversation JSON file
- `hook_event_name` - Name of the hook event

Event-specific fields include:
- **PreToolUse/PostToolUse**: `tool_name`, `tool_input`, `tool_response`
- **UserPromptSubmit**: `prompt`
- **Notification**: `message`

### Parsing Hook Data

Hooks in this repository use `jq` to parse JSON from stdin:

```bash
input=$(cat) && session_id=$(echo "$input" | jq -r '.session_id')
```

This pattern:
1. Captures all stdin into `$input` variable
2. Uses `jq` to extract specific fields from the JSON
3. Uses extracted values in logging and notifications

## Hook Architecture

Each hook script in `.claude/hooks/` follows the same pattern:

1. Read JSON from stdin: `input=$(cat)`
2. Parse with jq: `session_id=$(echo "$input" | jq -r '.session_id')`
3. Log to `.claude/hooks.log` with timestamp
4. Send macOS notification via `terminal-notifier`

All hooks are registered in `.claude/settings.json` with empty matchers (apply to all events).

## Monitoring Hook Activity

```bash
tail -f .claude/hooks.log
```

## Custom Slash Commands

This repository includes several workflow automation commands in `.claude/commands/`:

### Development Workflow Commands

- **`/prime`** - Load project context at session start (runs `git ls-files`, reads README.md)
- **`/create-spec [context]`** - Create specification files in `specs/` with phased implementation plans
- **`/execute-spec <spec-file> [phase]`** - Implement spec phases with automated testing and commits
- **`/review-spec-execution <spec-file>`** - Review implementation against spec requirements and run quality checks
- **`/create-slash-command`** - Scaffold new custom slash commands

### Directory Usage

- **`specs/`** - Feature specification files created by `/create-spec`, consumed by `/execute-spec`
- **`docs/`** - Project documentation (auto-generated or manually created)

### Typical Workflow Pattern

1. `/prime` - Initialize session context
2. `/create-spec <feature description>` - Plan the work
3. `/execute-spec specs/[file].md [phase]` - Implement incrementally
4. `/review-spec-execution [file]` - Verify quality and completeness

## Spec-Driven Development

When implementing features using the spec workflow:

- Specs are broken into phases with markdown task lists
- Each phase should be implemented, tested, and committed separately
- Use `/execute-spec` with phase numbers for incremental development
- Use `/review-spec-execution` to ensure all requirements are met before considering work complete
- Commit messages follow the pattern: `feat(phase-N): [description]`
