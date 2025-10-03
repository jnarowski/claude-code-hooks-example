#!/bin/bash

# SubagentStop Hook
# Triggered when a Claude Code subagent completes its task
# Receives JSON via stdin with: session_id, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] SubagentStop - Session: $session_id" >> .claude/hooks.log

terminal-notifier \
  -title 'Subagent Stop' \
  -message "Subagent completed | Session: $session_id" \
  -sound default
