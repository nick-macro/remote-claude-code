#!/bin/bash
set -euo pipefail

# Only run in remote Claude Code sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install uv if not already available
if ! command -v uv &>/dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Install just if not already available
if ! command -v just &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
fi

# Ensure PATH includes common install locations for the session
echo 'export PATH="/root/.local/bin:/usr/local/bin:$PATH"' >> "$CLAUDE_ENV_FILE"
