#!/usr/bin/env bash
#
# This script is sourced automatically by the Copilot Coding-Agent at start-up.
# Put exports, aliases, and other quick tweaks here.

# Example tweaks --------------------------------------------------------------
export EDITOR="code --wait"
export PAGER="less -R"

# Shortcuts
alias gs="git status -sb"
alias gl="git log --oneline --graph --decorate"

# Python virtual-env inside the workspace (optional)
if [[ -d "$HOME/workspace/.venv" ]]; then
  source "$HOME/workspace/.venv/bin/activate"
fi