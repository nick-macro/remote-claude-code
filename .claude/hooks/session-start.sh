#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  echo "Not a remote Claude Code session, skipping setup."
  exit 0
else
  echo "Remote Claude Code session detected, running setup..."
fi

# Install uv if not already available
if ! command -v uv &>/dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "uv is already installed."
fi

# Install just if not already available
if ! command -v just &>/dev/null; then
  echo "Installing just..."
  apt-get update -qq && apt-get install -y -qq just
else
  echo "just is already installed."
fi

# Install ruff if not already available
if ! command -v ruff &>/dev/null; then
  echo "Installing ruff..."
  uv tool install ruff
else
  echo "ruff is already installed."
fi

# Install ty if not already available
if ! command -v ty &>/dev/null; then
  echo "Installing ty..."
  uv tool install ty
else
  echo "ty is already installed."
fi

# Ensure PATH includes common install locations for the session
echo 'export PATH="/root/.local/bin:/usr/local/bin:$PATH"' >> "$CLAUDE_ENV_FILE"
