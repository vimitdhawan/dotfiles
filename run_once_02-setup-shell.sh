#!/usr/bin/env bash
# 02 — One-time shell setup: Oh My Zsh, fzf keybindings
# chezmoi: run_once

set -euo pipefail

echo "── chezmoi run_once: setting up shell ──"

# ─── Oh My Zsh ───────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "→ Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "→ Oh My Zsh already installed."
fi

# ─── fzf keybindings ────────────────────────────────────────────────────────
if command -v fzf &>/dev/null && [ ! -f "$HOME/.fzf.zsh" ]; then
  echo "→ Setting up fzf keybindings..."
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

# ─── Secrets file ────────────────────────────────────────────────────────────
if [ ! -f "$HOME/.secrets" ]; then
  echo "→ Creating ~/.secrets for API keys..."
  cat > "$HOME/.secrets" << 'EOF'
# ~/.secrets — NOT managed by chezmoi, NOT committed to git
# Store API keys and tokens here. Sourced by .zshrc.
#
# export NVIDIA_API_KEY=""
# export GOOGLE_API_KEY=""
# export GITHUB_TOKEN=""
# export ANTHROPIC_AUTH_TOKEN=""
EOF
  chmod 600 "$HOME/.secrets"
  echo "  Edit ~/.secrets to add your API keys."
fi

echo "── done ──"
