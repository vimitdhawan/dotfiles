#!/bin/bash
# run_once_01-install-packages.sh — chezmoi runs this ONCE on first apply
# Installs Homebrew (if missing) and all packages from Brewfile.

set -uo pipefail

echo "── chezmoi run_once: installing packages ──"

# ── Install Homebrew if not present ──────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "→ Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for the rest of this script (Apple Silicon vs Intel)
  if [[ -d "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -d "/usr/local/bin" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "→ Homebrew already installed."
fi

# ── Install packages from Brewfile ───────────────────────────────────────────
BREWFILE="$(chezmoi source-path)/Brewfile"

if [[ -f "$BREWFILE" ]]; then
  echo "→ Running brew bundle from $BREWFILE ..."
  brew bundle --file="$BREWFILE" || echo "⚠ Some packages failed — check output above."
else
  echo "⚠ Brewfile not found at $BREWFILE — skipping."
fi

echo "── done ──"
