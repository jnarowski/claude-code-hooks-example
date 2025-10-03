#!/bin/bash

# SessionEnd Hook
# Triggered when a Claude Code session ends
# Receives JSON via stdin with: session_id, cwd, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.cwd')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] SessionEnd - ID: $session_id, CWD: $cwd" >> .claude/hooks.log

terminal-notifier \
  -title 'Session Ended' \
  -message "Claude Code session $session_id ended" \
  -sound Glass
