#!/usr/bin/env bash
# 03 — macOS system preferences (idempotent)
# chezmoi: run_once
# Inspired by mathiasbynens/dotfiles/.macos

set -uo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Not macOS, skipping."
  exit 0
fi

echo "── chezmoi run_once: configuring macOS defaults ──"

# Close System Preferences to prevent overriding
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# ─── General UI/UX ──────────────────────────────────────────────────────────
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false 2>/dev/null || true

# ─── Dock ────────────────────────────────────────────────────────────────────
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock mru-spaces -bool false

# ─── Finder ──────────────────────────────────────────────────────────────────
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
chflags nohidden ~/Library 2>/dev/null || true

# ─── Keyboard ────────────────────────────────────────────────────────────────
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ─── Trackpad ────────────────────────────────────────────────────────────────
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ─── Screenshots ─────────────────────────────────────────────────────────────
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
mkdir -p "$HOME/Desktop/Screenshots"

# ─── Safari (sandboxed — may fail silently) ──────────────────────────────────
defaults write com.apple.Safari UniversalSearchEnabled -bool false 2>/dev/null || true
defaults write com.apple.Safari SuppressSearchSuggestions -bool true 2>/dev/null || true
defaults write com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null || true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true 2>/dev/null || true
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true 2>/dev/null || true

# ─── Chrome ──────────────────────────────────────────────────────────────────
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome DisablePrintPreview -bool true

# ─── Terminal ────────────────────────────────────────────────────────────────
defaults write com.apple.terminal SecureKeyboardEntry -bool true
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# ─── Activity Monitor ───────────────────────────────────────────────────────
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# ─── Mac App Store ───────────────────────────────────────────────────────────
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
defaults write com.apple.commerce AutoUpdate -bool true

# ─── Misc ────────────────────────────────────────────────────────────────────
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true 2>/dev/null || true
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4

echo "Restarting Dock and Finder..."
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
echo "── done (some changes need logout/restart) ──"
