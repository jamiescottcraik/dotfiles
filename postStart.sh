#!/usr/bin/env bash
#
# Runs *once* every time a new container is created (Codespace rebuild).
# Good place to install global tools.

set -euo pipefail

echo "Installing global npm packages..."
npm install -g eslint prettier