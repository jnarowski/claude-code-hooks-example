#!/bin/bash

# Notification Hook
# Triggered when Claude Code sends a notification event
# Receives JSON via stdin with: session_id, message, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
message=$(echo "$input" | jq -r '.message')

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Notification - Message: $message, Session: $session_id" >> .claude/hooks.log

terminal-notifier \
  -title 'Claude Notification' \
  -subtitle "$message" \
  -message "Session: $session_id"
