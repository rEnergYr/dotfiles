<div align="center">

# 🖥️ Tmux Configuration

*Terminal multiplexer setup for productive development workflows*

[![Tmux](https://img.shields.io/badge/Tmux-3.0+-1e1e2e.svg?style=for-the-badge&logo=tmux)](https://github.com/tmux/tmux)
[![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin_Mocha-1e1e2e.svg?style=for-the-badge)](https://github.com/catppuccin/tmux)
[![TPM](https://img.shields.io/badge/Plugin_Manager-TPM-1e1e2e.svg?style=for-the-badge)](https://github.com/tmux-plugins/tpm)

</div>

---

## ✨ Features

- ⌨️ **Vim-like Navigation** - hjkl for pane movement
- 🎨 **Catppuccin Theme** - Beautiful Mocha color scheme
- 🖱️ **Mouse Support** - Click to switch panes and resize
- 🔍 **FZF Integration** - Fuzzy find sessions and windows
- 📋 **System Clipboard** - Seamless copy/paste integration
- ⚡ **Fast Response** - Zero escape time delay
- 🔄 **Auto Renumber** - Windows always in order

---

## 🎯 Key Bindings

### Prefix Key

**Ctrl+A** - Custom prefix (instead of default Ctrl+B)

### Essential Commands

| Keybinding | Action | Description |
|------------|--------|-------------|
| `Ctrl+A` `r` | Reload config | Source `~/.tmux.conf` |
| `Ctrl+A` `^C` | New window | Create window in HOME directory |
| `Ctrl+A` `c` | Kill pane | Close current pane |

### Window Management

| Keybinding | Action |
|------------|--------|
| `Ctrl+A` `H` | Previous window |
| `Ctrl+A` `L` | Next window |

### Pane Splitting

| Keybinding | Action | Opens in |
|------------|--------|----------|
| `Ctrl+A` `s` | Vertical split | Current directory |
| `Ctrl+A` `v` | Horizontal split | Current directory |

### Pane Navigation (Vim-style)

| Keybinding | Action |
|------------|--------|
| `Ctrl+A` `h` | Move to left pane |
| `Ctrl+A` `j` | Move to pane below |
| `Ctrl+A` `k` | Move to pane above |
| `Ctrl+A` `l` | Move to right pane |

---

## 🔌 Plugins

This configuration uses [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager) with the following plugins:

| Plugin | Description | Link |
|--------|-------------|------|
| **TPM** | Plugin manager | [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) |
| **tmux-fzf** | Fuzzy finder integration | [sainnhe/tmux-fzf](https://github.com/sainnhe/tmux-fzf) |
| **Catppuccin** | Beautiful Mocha theme | [omerxx/catppuccin-tmux](https://github.com/omerxx/catppuccin-tmux) |

---

## 🎨 Theme Configuration

### Catppuccin Mocha

**Window Styling:**

- Custom separators with transparent background
- Window number on the right
- Current window shows zoom indicator `()`
- Middle separator: `█`

**Status Bar:**

- **Left**: Session name
- **Right**: Current user
- Transparent background
- Icon-based fill style

**Colors:**

- Transparent/default background
- Catppuccin Mocha palette
- Consistent with Neovim & Ghostty

---

## ⚙️ General Settings

| Option | Value | Description |
|--------|-------|-------------|
| `base-index` | `1` | Windows start at 1 (not 0) |
| `status-position` | `top` | Status bar at top of screen |
| `escape-time` | `0` | No delay for Escape key |
| `history-limit` | `1000000` | 1M lines of scrollback |
| `renumber-windows` | `on` | Auto-renumber after closing |
| `set-clipboard` | `on` | Sync with system clipboard |
| `prefix` | `C-a` | Ctrl+A prefix key |
| `mouse` | `on` | Mouse support enabled |

---

## 🚀 Installation

### 1. Install Tmux

**macOS:**

```bash
brew install tmux
```

**Linux:**

```bash
sudo apt install tmux
```

### 2. Install TPM (Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 3. Symlink Configuration

```bash
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### 4. Install Plugins

1. Start tmux: `tmux`
2. Press `Ctrl+A` then `I` (capital i) to install plugins
3. Wait for plugins to install

### 5. Reload Configuration

Press `Ctrl+A` then `r` to reload the config

---

## 💡 Usage Tips

### Starting a Session

```bash
# Start new session
tmux

# Start named session
tmux new -s dev

# Attach to existing session
tmux attach -t dev

# List sessions
tmux ls
```

### Working with Panes

```bash
# Split horizontally (side by side)
Ctrl+A v

# Split vertically (top and bottom)
Ctrl+A s

# Navigate between panes
Ctrl+A h/j/k/l

# Resize with mouse
# Click and drag pane borders
```

### FZF Integration

```bash
# Fuzzy find sessions/windows
Ctrl+A Ctrl+F
```

### Copy Mode

```bash
# Enter copy mode
Ctrl+A [

# Navigate with vim keys
# Press 'v' to start selection
# Press 'y' to copy to system clipboard
```

---

## 🎨 Customization

### Change Prefix Key

```bash
# In tmux.conf
set -g prefix C-b  # Back to default Ctrl+B
# or
set -g prefix C-s  # Use Ctrl+S
```

### Add Status Modules

```bash
# Available modules: application, battery, cpu, date_time, directory, host, session, uptime, user, weather
set -g @catppuccin_status_modules_right "date_time battery cpu"
```

### Adjust Theme Colors

```bash
# Change window separator
set -g @catppuccin_window_middle_separator " | "

# Change fill style
set -g @catppuccin_window_default_fill "all"
```

---

## 🔧 Troubleshooting

### Plugins Not Loading

```bash
# Reinstall TPM
rm -rf ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload tmux
tmux kill-server
tmux
# Then: Ctrl+A I
```

### Colors Look Wrong

```bash
# Check terminal supports 256 colors
echo $TERM  # Should be: screen-256color or tmux-256color

# Add to tmux.conf if needed
set -g default-terminal "tmux-256color"
```

### Mouse Not Working

```bash
# Ensure mouse mode is on
tmux show-options -g | grep mouse
# Should show: mouse on
```

---

## 📚 Useful Commands

| Command | Description |
|---------|-------------|
| `tmux ls` | List all sessions |
| `tmux kill-session -t name` | Kill specific session |
| `tmux kill-server` | Kill all sessions |
| `tmux info` | Show tmux info |
| `tmux list-keys` | Show all key bindings |

---

## 🎯 Integration with Dev Workflow

This tmux config pairs perfectly with the custom `dev` function from Nushell:

```bash
# Run from Nushell
dev

# Creates tmux session with:
# - Neovim in main pane
# - AI assistant in side pane
```

---

<div align="center">

Crafted in Middle-Stack ⚔️ for terminal productivity

*Part of [dotfiles](../..) collection*

</div>
