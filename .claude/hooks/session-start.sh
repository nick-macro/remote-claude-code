#!/bin/bash
set -euo pipefail

LOG_FILE="logs/claude-hook-output.txt"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"
}

# Only run in remote Claude Code sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  log "Not a remote Claude Code session, skipping setup."
  exit 0
else
  log "Remote Claude Code session detected, running setup..."
fi

# Install uv if not already available
if ! command -v uv &>/dev/null; then
  log "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  log "uv is already installed."
fi

# Install just if not already available
if ! command -v just &>/dev/null; then
  log "Installing just..."
  apt-get update -qq && apt-get install -y -qq just
else
  log "just is already installed."
fi

# Install ruff if not already available
if ! command -v ruff &>/dev/null; then
  log "Installing ruff..."
  uv tool install ruff
else
  log "ruff is already installed."
fi

# Install ty if not already available
if ! command -v ty &>/dev/null; then
  log "Installing ty..."
  uv tool install ty
else
  log "ty is already installed."
fi

# Ensure PATH includes common install locations for the session
echo 'export PATH="/root/.local/bin:/usr/local/bin:$PATH"' >> "$CLAUDE_ENV_FILE"
