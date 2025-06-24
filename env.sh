#!/usr/bin/env bash
#
# Environment setup for jamiescottcraik's Copilot Coding Agent
# This file is sourced for every shell session and Copilot task

# Editor & Terminal
export EDITOR="code --wait"
export PAGER="less -R"
export TERM="xterm-256color"

# Development paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# Node.js & npm
export NODE_ENV="${NODE_ENV:-development}"
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# Python
export PYTHONPATH="${PYTHONPATH}:."
export PIPENV_VENV_IN_PROJECT=1
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Ruby
export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:$PATH"

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Git shortcuts
alias gs="git status -sb"
alias gl="git log --oneline --graph --decorate -20"
alias gp="git pull --rebase"
alias gc="git commit -v"
alias gca="git commit -v --amend"
alias gb="git branch -vv"
alias gco="git checkout"
alias gd="git diff"
alias gds="git diff --staged"

# Development shortcuts
alias nr="npm run"
alias nrd="npm run dev"
alias nrt="npm run test"
alias nrb="npm run build"
alias py="python"
alias dj="python manage.py"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcl="docker-compose logs -f"

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -alh"
alias la="ls -A"

# Utility functions
function mkcd() { mkdir -p "$1" && cd "$1"; }
function ports() { lsof -PiTCP -sTCP:LISTEN; }
function serve() { python -m http.server "${1:-8000}"; }

# Auto-activate Python virtual environments
if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
elif [[ -f "venv/bin/activate" ]]; then
    source venv/bin/activate
elif [[ -f "$HOME/workspace/.venv/bin/activate" ]]; then
    source "$HOME/workspace/.venv/bin/activate"
fi

# Load project-specific .env files (if they exist)
if [[ -f ".env" ]]; then
    set -a
    source .env
    set +a
fi

# GitHub CLI aliases
alias prs="gh pr list"
alias issues="gh issue list"
alias prv="gh pr view --web"

# Quick project setup checker
function check_project() {
    echo "🔍 Project Analysis:"
    [[ -f "package.json" ]] && echo "  ✓ Node.js project detected"
    [[ -f "requirements.txt" || -f "Pipfile" || -f "pyproject.toml" ]] && echo "  ✓ Python project detected"
    [[ -f "Gemfile" ]] && echo "  ✓ Ruby project detected"
    [[ -f "docker-compose.yml" || -f "Dockerfile" ]] && echo "  ✓ Docker configuration found"
    [[ -d ".git" ]] && echo "  ✓ Git repository ($(git branch --show-current))"
}

# Welcome message
echo "🚀 Copilot environment loaded for @jamiescottcraik"
check_project

# GitHub SSH helpers
alias ssh-github-load="op document get 'GitHub SSH Private Key' > ~/.ssh/github_ed25519 && chmod 600 ~/.ssh/github_ed25519"
alias ssh-github-test="ssh -T git@github.com"

# Ollama helpers
alias ollama-list="ollama list"
alias ollama-chat="ollama run llama3.2"
alias ollama-code="ollama run codellama"

# Function to switch between OpenAI and Ollama
ai_switch() {
    case "$1" in
        "ollama")
            export LLM_PROVIDER="ollama"
            export LLM_API_BASE="http://localhost:11434"
            export LLM_MODEL="${2:-llama3.2}"
            echo "🦙 Switched to Ollama (model: $LLM_MODEL)"
            ;;
        "openai")
            export LLM_PROVIDER="openai"
            export LLM_API_BASE="https://api.openai.com/v1"
            export LLM_MODEL="${2:-gpt-4}"
            echo "🤖 Switched to OpenAI (model: $LLM_MODEL)"
            ;;
        *)
            echo "Usage: ai_switch [ollama|openai] [model]"
            echo "Current: ${LLM_PROVIDER:-not set}"
            ;;
    esac
}

# Auto-load GitHub SSH if in a git repo
if [ -d .git ] && command -v op &> /dev/null; then
    # Check if SSH key exists
    if [ ! -f ~/.ssh/github_ed25519 ]; then
        echo "💡 Tip: Load GitHub SSH with: ssh-github-load"
    fi
fi
