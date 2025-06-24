#!/usr/bin/env bash
#
# Post-start setup for Copilot Coding Agent
# Runs once when the container is created

set -euo pipefail

echo "🔧 Setting up development environment..."

# Create common directories
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.npm-global"
mkdir -p "$HOME/.gem"

# Install global Node.js tools
echo "📦 Installing Node.js global packages..."
npm install -g \
    typescript \
    ts-node \
    nodemon \
    prettier \
    eslint \
    @biomejs/biome \
    vercel \
    netlify-cli \
    npm-check-updates \
    concurrently \
    wait-on

# Install Ruby gems (if Ruby is available)
if command -v gem &> /dev/null; then
    echo "💎 Installing Ruby gems..."
    gem install bundler rails rubocop solargraph
fi

# Install Python tools globally
echo "🐍 Installing Python tools..."
pip install --user \
    pipx \
    poetry \
    pipenv \
    cookiecutter \
    pre-commit

# Install GitHub CLI extensions
if command -v gh &> /dev/null; then
    echo "🐙 Installing GitHub CLI extensions..."
    gh extension install github/gh-copilot || true
    gh extension install mislav/gh-branch || true
fi

# Setup Git configuration
echo "📝 Configuring Git..."
git config --global user.name "Jamie Scott Craik"
git config --global user.email "jamiescottcraik@users.noreply.github.com"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra
git config --global rerere.enabled true

# Install useful VS Code extensions (if in Codespace)
if [[ -n "${CODESPACES:-}" ]]; then
    echo "🎨 Installing VS Code extensions..."
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension esbenp.prettier-vscode
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension charliermarsh.ruff
    code --install-extension GitHub.copilot
    code --install-extension GitHub.copilot-chat
    code --install-extension eamodio.gitlens
    code --install-extension usernamehw.errorlens
    code --install-extension bradlc.vscode-tailwindcss
fi

# Download common .gitignore templates
echo "📄 Setting up gitignore templates..."
mkdir -p "$HOME/.gitignore_templates"
curl -sL https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore > "$HOME/.gitignore_templates/node.gitignore"
curl -sL https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore > "$HOME/.gitignore_templates/python.gitignore"
curl -sL https://raw.githubusercontent.com/github/gitignore/main/Ruby.gitignore > "$HOME/.gitignore_templates/ruby.gitignore"

echo "✅ Development environment setup complete!"
