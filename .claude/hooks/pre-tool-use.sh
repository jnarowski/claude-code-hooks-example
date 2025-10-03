#!/bin/bash

# PreToolUse Hook
# Triggered before Claude Code executes a tool
# Receives JSON via stdin with: session_id, tool_name, tool_input, cwd, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
tool_name=$(echo "$input" | jq -r '.tool_name')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] PreToolUse - Tool: $tool_name, Session: $session_id" >> .claude/hooks.log

terminal-notifier \
  -title 'PreToolUse' \
  -subtitle "Tool: $tool_name" \
  -message "Session: $session_id"
