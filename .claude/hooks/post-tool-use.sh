#!/bin/bash

# PostToolUse Hook
# Triggered after Claude Code executes a tool
# Receives JSON via stdin with: session_id, tool_name, tool_input, tool_response, cwd, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
tool_name=$(echo "$input" | jq -r '.tool_name')
success=$(echo "$input" | jq -r '.tool_response.success // "unknown"')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] PostToolUse - Tool: $tool_name, Success: $success, Session: $session_id" >> .claude/hooks.log

terminal-notifier \
  -title 'PostToolUse' \
  -subtitle "Tool: $tool_name" \
  -message "Success: $success | Session: $session_id"
