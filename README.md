# dotfiles

My development environment managed by [chezmoi](https://chezmoi.io). One command to set up a new Mac.

## Quick start (new machine)

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install chezmoi and apply dotfiles
brew install chezmoi
chezmoi init --apply https://github.com/YOUR_USERNAME/dotfiles.git
```

`chezmoi init` will prompt you for:
- **Machine type** — `personal` or `work` (controls which packages and configs are installed)
- **Git name and emails** — personal and work emails for git multi-account setup

Everything else runs automatically.

## What gets installed

### Config files (synced on every `chezmoi apply`)

| File | Manages |
|---|---|
| `~/.zshrc` | Shell — aliases, PATH, plugins, tool initialization |
| `~/.gitconfig` | Git — delta, aliases, machine-specific email |
| `~/.config/git/{work,personal}` | Git multi-account — email override by directory (`~/Work/` vs `~/Personal/`) |
| `~/.config/git/ignore` | Global gitignore |
| `~/.config/starship.toml` | Prompt — git status, K8s context, language versions |
| `~/.config/ghostty/config` | Ghostty terminal — font, theme, padding |
| `~/.config/mise/config.toml` | Version manager — Go 1.24, Node 22, Python 3.13 |
| `~/.config/nvim/` | Neovim — LazyVim with Go, TS, Python, Rust support |
| `~/.ideavimrc` | GoLand/IntelliJ vim keybindings |
| `~/.npmrc` | npm — save-exact, quiet output |
| `~/.ssh/config` | SSH — keychain integration, GitHub host, work hosts |
| `~/Library/.../Code/User/` | VS Code — settings and keybindings |

### Scripts (run automatically by chezmoi)

| Script | Type | What it does |
|---|---|---|
| `01-install-packages` | run_once | Installs Homebrew + shared and machine-specific brew packages |
| `02-setup-shell` | run_once | Installs Oh My Zsh, fzf keybindings, creates `~/.secrets` |
| `03-configure-macos` | run_once | Sets macOS defaults (Dock, Finder, keyboard, screenshots) |
| `04-install-vscode-extensions` | run_onchange | Installs VS Code extensions (re-runs when list changes) |

### Brewfile split

| File | Contents |
|---|---|
| `Brewfile` | Shared packages — CLI tools, editors, K8s, fonts, common GUI apps |
| `Brewfile.personal` | Docker Desktop |
| `Brewfile.work` | Colima, saml2aws, GoLand, Slack |

## Daily usage

```bash
# Apply latest dotfiles
chezmoi apply -v

# See what would change
chezmoi diff

# Edit a managed file (opens in $EDITOR, auto-copies to source)
chezmoi edit ~/.zshrc

# Pull updates from remote and apply
chezmoi update

# Re-init (re-prompts for machine type, emails)
chezmoi init
```

### Shortcuts (defined in .zshrc)

```bash
dots    # cd to chezmoi source directory
dotsa   # chezmoi apply -v
dotsd   # chezmoi diff
dotse   # chezmoi edit
dotsu   # chezmoi update
```

## Git multi-account setup

The default git email is set based on machine type. Additionally, `includeIf` overrides email by directory:

- Repos in `~/Work/` → work email
- Repos in `~/Personal/` → personal email

This works on both machines, so you can use personal repos on your work Mac.

## Adding new tools

1. Add to the appropriate Brewfile (`Brewfile`, `Brewfile.personal`, or `Brewfile.work`)
2. Add shell config to `dot_zshrc` if needed
3. `chezmoi apply -v` to deploy
4. `brew bundle --file=~/Vimit_Codebase/dotfiles/Brewfile` to install

## How chezmoi scripts work

- **`run_once_*`** — Runs once during `chezmoi apply`. Re-runs only if the script content changes.
- **`run_onchange_*`** — Runs during `chezmoi apply` when a watched file changes (via hash in the script).
- **`.tmpl` suffix** — File is a Go template. chezmoi renders it using your config data before deploying.
- **`dot_` prefix** — Maps to `.` in home directory (`dot_zshrc` → `~/.zshrc`).
- **`private_` prefix** — Sets `0700` permissions on the directory/file.

## Structure

```
.
├── .chezmoi.toml.tmpl          # init prompts (machine type, git emails)
├── .chezmoiignore              # files to not deploy to ~
├── Brewfile                    # shared packages
├── Brewfile.personal           # personal-only (Docker Desktop)
├── Brewfile.work               # work-only (Colima, saml2aws, GoLand, Slack)
├── dot_zshrc                   # shell config
├── dot_gitconfig.tmpl          # git config (templated for machine type)
├── dot_ideavimrc               # GoLand vim keybindings
├── dot_npmrc                   # npm config
├── dot_config/
│   ├── ghostty/config          # terminal config
│   ├── git/{ignore,work,personal}
│   ├── mise/config.toml        # language version manager
│   ├── nvim/                   # Neovim (LazyVim)
│   └── starship.toml           # prompt config
├── private_dot_ssh/config.tmpl # SSH config (templated)
├── Library/.../Code/User/      # VS Code settings
├── scripts/
│   └── vscode-extensions.txt   # VS Code extension list
├── run_once_01-install-packages.sh.tmpl
├── run_once_02-setup-shell.sh
├── run_once_03-configure-macos.sh
└── run_onchange_04-install-vscode-extensions.sh.tmpl
```
