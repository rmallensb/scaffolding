#!/usr/bin/env bash
set -euo pipefail

if ! op whoami &>/dev/null; then
  eval "$(op signin)"
fi

# Add secrets here: export VAR=$(op item get "Item Name" --fields field_name)
#export OPENAI_API_KEY=$(op item get "OpenAI API Key" --fields api_key)
# export ANTHROPIC_API_KEY=$(op item get "Anthropic API Key" --fields api_key)

export TEST=$(op item get "OpenAI Api Key" --vault "Employee" --fields 

echo "Secrets loaded."
