#!/bin/bash

# PreCompact Hook
# Triggered before Claude Code compacts conversation context
# Receives JSON via stdin with: session_id, cwd, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.cwd')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] PreCompact - Session: $session_id, CWD: $cwd" >> .claude/hooks.log

terminal-notifier \
  -title 'PreCompact' \
  -message "Context compaction starting | Session: $session_id" \
  -group compact
