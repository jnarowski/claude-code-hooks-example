#!/bin/bash

# Stop Hook
# Triggered when Claude Code stops responding (user interruption)
# Receives JSON via stdin with: session_id, cwd, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.cwd')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Stop - Session: $session_id, CWD: $cwd" >> .claude/hooks.log

terminal-notifier \
  -title 'Claude Stop' \
  -message "Session $session_id stopped" \
  -sound default
