#!/bin/bash

# UserPromptSubmit Hook
# Triggered when user submits a prompt to Claude Code
# Receives JSON via stdin with: session_id, prompt, cwd, etc.

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id')
cwd=$(echo "$input" | jq -r '.cwd')
prompt=$(echo "$input" | jq -r '.prompt' | head -c 50)

echo "[$(date '+%Y-%m-%d %H:%M:%S')] UserPromptSubmit - CWD: $cwd, Prompt: $prompt..., Session: $session_id" >> .claude/hooks.log

terminal-notifier \
  -title 'User Prompt' \
  -message "$prompt..." \
  -group prompt
