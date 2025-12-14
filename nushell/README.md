<div align="center">

# 🐚 Nushell Configuration

*Modern shell with structured data pipelines and intuitive scripting*

[![Nushell](https://img.shields.io/badge/Nushell-0.90+-1e1e2e.svg?style=for-the-badge&logo=gnubash)](https://www.nushell.sh)
[![Starship](https://img.shields.io/badge/Prompt-Starship-1e1e2e.svg?style=for-the-badge&logo=starship)](https://starship.rs)
[![Carapace](https://img.shields.io/badge/Completions-Carapace-1e1e2e.svg?style=for-the-badge)](https://github.com/rsteube/carapace-bin)

</div>

---

## ✨ Features

- 🚀 **Starship Prompt** - Fast and customizable prompt
- 🔍 **Carapace Completions** - Multi-shell argument completion
- 🎨 **Custom Aliases** - Quick shortcuts for common commands
- 📦 **Auto Install Script** - One-command dependency installation
- 🖼️ **Neofetch Integration** - Custom ASCII art on startup
- ⚡ **Productivity Functions** - `dev` and `s` for fast workflows
- 🎯 **AI Integration** - GitHub Copilot CLI with Claude Sonnet 4.5

---

## 📋 Files Overview

| File | Purpose |
|------|---------|
| `config.nu` | Main configuration, aliases, and custom functions |
| `env.nu` | Environment setup and Carapace initialization |
| `install.nu` | Automated package installation script |

---

## ⚡ Aliases

Quick shortcuts for common commands:

| Alias | Command | Description |
|-------|---------|-------------|
| `l` | `ls` | Quick listing |
| `ll` | `ls -l` | Detailed listing |
| `n` | `nvim` | Open Neovim |
| `cat` | `bat` | Prettier cat with syntax highlighting |
| `d` | `docker` | Docker shortcut |
| `p` | `pnpm` | Package manager |
| `ai` | `copilot --model claude-sonnet-4.5` | GitHub Copilot CLI with Claude |

---

## 🔧 Custom Functions

### `dev` - Development Environment

Launch a complete development environment with tmux sessions.

**Usage:**

```bash
dev
```

**What it does:**

1. Creates a new tmux session named `dev`
2. Opens Neovim in the first window
3. Creates a second window with AI assistant (Copilot)
4. Automatically attaches to the session

**Perfect for:**

- Starting new coding sessions
- Pair programming with AI
- Multi-pane development workflow

---

### `s` - Fuzzy File Search

Quickly find and open files in Neovim with live preview.

**Usage:**

```bash
s
```

**What it does:**

1. Opens FZF fuzzy finder
2. Shows live preview with syntax highlighting (via `bat`)
3. Opens selected file in Neovim

**Features:**

- Real-time file preview
- Syntax highlighting
- Fast file navigation
- Line numbers in preview

---

## 🎯 Integrations

### Starship Prompt

**Auto-initialized on startup**

- Git status integration
- Directory navigation
- Command duration
- Error indicators

**Location:** `$nu.data-dir/vendor/autoload/starship.nu`

### Carapace Completions

**Provides completions for:**

- Git commands
- Docker CLI
- NPM/PNPM
- GitHub CLI
- And 600+ more tools

**Location:** `$nu.cache-dir/carapace.nu`

### Neofetch

**Custom ASCII art display on startup**

- Shows system information
- Custom logo from `~/.config/neofetch/ascii.txt`
- Disabled banner for clean output

---

## 📦 Installation

### 1. Install Nushell

**macOS:**

```bash
brew install nushell
```

**Linux:**

```bash
cargo install nu
```

### 2. Symlink Configurations

```bash
# Create Nushell config directory
mkdir -p ~/.config/nushell

# Symlink config files
ln -s ~/.dotfiles/nushell/config.nu ~/.config/nushell/config.nu
ln -s ~/.dotfiles/nushell/env.nu ~/.config/nushell/env.nu
```

### 3. Run Installation Script

This will install all required dependencies via Homebrew:

```bash
nu ~/.dotfiles/nushell/install.nu
```

**Packages installed:**

- `starship` - Cross-shell prompt
- `tmux` - Terminal multiplexer
- `carapace` - Completion generator
- `neovim` - Text editor
- `media-control` - Media player control
- `fd` - Fast file finder
- `fzf` - Fuzzy finder
- `ripgrep` - Fast grep alternative
- `lazygit` - Git TUI
- `lazydocker` - Docker TUI
- `lazysql` - SQL TUI
- `copilot-cli` - GitHub Copilot CLI
- `neofetch` - System info
- `httpie` - HTTP client
- `bat` - Cat with syntax highlighting
- `rust` - Rust toolchain
- `node` - Node.js runtime
- `pnpm` - Fast package manager

### 4. Restart Shell

```bash
exit
# Open new terminal
```

---

## 🎨 Customization

### Adding Custom Aliases

Edit `config.nu`:

```nushell
alias g = git
alias dc = docker-compose
alias k = kubectl
```

### Creating Custom Functions

```nushell
def myfunction [arg1: string, arg2: int] {
    echo $"Hello ($arg1), you are ($arg2) years old"
}
```

### Changing AI Model

```nushell
# In config.nu, change the ai alias
alias ai = copilot --model gpt-4  # Use GPT-4
alias ai = copilot --model claude-opus  # Use Claude Opus
```

---

## 💡 Nushell Tips & Tricks

### Working with Structured Data

```nushell
# List files as structured data
ls | where size > 1mb | sort-by modified

# Parse JSON
http get https://api.github.com/users/octocat | get name

# Convert to different formats
ls | to json
ls | to yaml
ls | to csv
```

### Pipelines

```nushell
# Count files by extension
ls | group-by extension | transpose | sort-by column1

# Find large files
ls **/* | where size > 100mb | sort-by size --reverse
```

### Environment Variables

```nushell
# Set environment variable
$env.MY_VAR = "value"

# Use in command
echo $env.MY_VAR
```

### Command Substitution

```nushell
# Capture command output
let files = (ls | length)
echo $"Found ($files) files"
```

---

## 🚀 Productivity Workflow

### Morning Routine

```bash
# Start shell (Neofetch shows system info)
nu

# Check what you're working on
ls -l

# Start development environment
dev

# In separate pane, fuzzy find files
s
```

### Quick Navigation

```bash
# List files
l

# Detailed view
ll

# Open file in Neovim
n myfile.rs

# Search and open
s
```

### Docker Workflow

```bash
# Quick docker commands
d ps
d images
d compose up -d

# Or use LazyDocker in Neovim
n
# Then: <leader>ld
```

---

## 🔧 Configuration Details

### config.nu

**Settings:**

- `show_banner = false` - No banner on startup
- Starship initialization
- Carapace completions sourcing
- Neofetch with custom ASCII
- All aliases and functions

### env.nu

**Responsibilities:**

- Creates cache directory
- Generates Carapace completions
- Environment variable setup

### install.nu

**Features:**

- Validates Homebrew installation
- Installs packages with error handling
- Silent installation with progress
- Exit code validation

---

## 🛠️ Troubleshooting

### Starship Not Loading

```bash
# Regenerate Starship config
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```

### Carapace Completions Missing

```bash
# Regenerate Carapace completions
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
```

### Function Not Found

```bash
# Reload configuration
source ~/.config/nushell/config.nu
```

### Install Script Fails

```bash
# Check Homebrew
brew --version

# Update Homebrew
brew update

# Run install script with verbose output
nu ~/.dotfiles/nushell/install.nu
```

---

## 📚 Resources

- [Nushell Book](https://www.nushell.sh/book/) - Official documentation
- [Starship Config](https://starship.rs/config/) - Prompt customization
- [Carapace Completers](https://rsteube.github.io/carapace-bin/completers.html) - Available completions

---

## 🎯 Key Differences from Bash/Zsh

| Feature | Bash/Zsh | Nushell |
|---------|----------|---------|
| **Data** | Text streams | Structured tables |
| **Pipes** | String-based | Type-aware |
| **Errors** | Exit codes | Structured errors |
| **Variables** | `$var` | `$var` or `let var = ...` |
| **Functions** | `function name() {}` | `def name [] {}` |

---

<div align="center">

Crafted in Middle-Stack ⚔️ for modern shell experience

*Part of [dotfiles](../..) collection*

</div>
