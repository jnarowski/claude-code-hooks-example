# Claude Code Hooks Example

Example project demonstrating Claude Code hooks with macOS notifications via [`terminal-notifier`](https://github.com/julienXX/terminal-notifier).

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

## Directory Structure

```text
.claude/
├── settings.json          # Hook configuration and permissions
├── hooks.log             # Timestamped hook activity log
├── hooks/                # Hook scripts that fire during Claude Code events
│   ├── pre-tool-use.sh
│   ├── post-tool-use.sh
│   ├── user-prompt-submit.sh
│   ├── session-start.sh
│   ├── session-end.sh
│   ├── stop.sh
│   ├── subagent-stop.sh
│   ├── pre-compact.sh
│   └── notification.sh
└── commands/             # Custom slash commands for workflow automation
    ├── prime.md
    ├── create-spec.md
    ├── execute-spec.md
    ├── review-spec-execution.md
    └── create-slash-command.md

docs/                     # Project documentation (auto-generated or manual)
specs/                    # Feature specifications created by /create-spec
```

## Slash Commands

This project includes custom slash commands to streamline development workflows:

### `/prime`

**Purpose**: Load context at the start of a new Claude Code session

**Usage**: `/prime`

**What it does**:
- Runs `git ls-files` to see project structure
- Reads README.md to understand the project
- Reports a summary of the project's purpose and functionality

**When to use**: At the beginning of any new session to help Claude understand your project context

---

### `/create-spec <context>`

**Purpose**: Create a detailed specification document for a feature or project

**Usage**: `/create-spec [optional context description]`

**What it does**:
- Creates a markdown spec file in `specs/[timestamp]-[spec-name].md`
- Breaks implementation into phases with individual markdown tasks
- Includes all necessary context for implementation

**Arguments**:
- `<context>` (optional): Description of the feature to spec out. If omitted, uses existing conversation context

**When to use**: Before implementing complex features to plan the work and break it into manageable phases

---

### `/execute-spec <spec-file> [phase]`

**Purpose**: Implement work outlined in a specification file

**Usage**: `/execute-spec specs/[filename].md [phase-number]`

**What it does**:
- Reads the spec file and loads relevant context
- Implements the plan one phase at a time
- After each phase: runs linting/tests, updates markdown tasks, commits changes
- Creates commits with message: `feat(phase-N): [description]`

**Arguments**:
- `<spec-file>` (required): Path to the spec file in `specs/`
- `[phase]` (optional): Specific phase number to execute. If omitted, executes all phases

**When to use**: To systematically implement a feature specification with proper testing and version control

---

### `/review-spec-execution <spec-file>`

**Purpose**: Review completed work against the original specification

**Usage**: `/review-spec-execution [spec-filename]`

**What it does**:
- Loads the spec file and compares against git changes
- Runs quality checks (types, lint, tests, build)
- Identifies missing tasks, quality issues, and test gaps
- Provides a detailed report of completion status and what needs fixing

**Arguments**:
- `<spec-file>` (required): Name of the spec file to review against

**When to use**: After implementing a spec (or phases) to ensure all requirements are met and quality standards are maintained

---

### `/create-slash-command`

**Purpose**: Create a new custom slash command

**Usage**: `/create-slash-command`

**What it does**:
- Uses a template structure to create a new command file in `.claude/commands/`
- Asks clarifying questions to implement the command correctly
- Guides you through defining variables, workflow, and report sections

**When to use**: When you want to automate repetitive workflows or create project-specific commands

## Workflow Example

A typical development workflow using these commands:

1. **Start session**: `/prime` - Load project context
2. **Plan feature**: `/create-spec Implement user authentication` - Create detailed spec
3. **Implement**: `/execute-spec specs/20250103-user-authentication.md 1` - Execute phase 1
4. **Review**: `/review-spec-execution 20250103-user-authentication.md` - Check quality and completeness
5. **Continue**: `/execute-spec specs/20250103-user-authentication.md 2` - Execute next phase
6. **Final review**: `/review-spec-execution 20250103-user-authentication.md` - Ensure everything is complete
