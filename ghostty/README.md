<div align="center">

# 👻 Ghostty Configuration

*Modern, GPU-accelerated terminal emulator with stunning visual effects*

[![Ghostty](https://img.shields.io/badge/Ghostty-Latest-1e1e2e.svg?style=for-the-badge&logo=ghostty)](https://ghostty.org)
[![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin_Mocha-1e1e2e.svg?style=for-the-badge)](https://github.com/catppuccin/ghostty)
[![FiraCode](https://img.shields.io/badge/Font-FiraCode_Nerd-1e1e2e.svg?style=for-the-badge)](https://www.nerdfonts.com)

</div>

---

## ✨ Features

- 🎨 **Catppuccin Mocha Theme** - Soothing pastel color scheme
- ⚡ **GPU-Accelerated** - Hardware-powered rendering for blazing performance
- 🔤 **Nerd Font Integration** - FiraCode with icon support
- 💫 **Custom Cursor Shader** - Beautiful cursor sweep animation
- 🌫️ **Translucent Background** - 97% opacity with 5px blur
- 🖱️ **Auto-Hide Cursor** - Hides while typing for cleaner view
- ⌨️ **macOS Optimization** - Option key as Alt for shortcuts
- 📐 **Perfect Dimensions** - 110×35 window size for optimal workflow

---

## 🎨 Theme & Appearance

### Color Scheme

**Catppuccin Mocha** - A soothing pastel theme that's easy on the eyes

- Consistent with Neovim and Tmux configurations
- Dark background with vibrant accents
- Excellent contrast for readability
- Perfect for long coding sessions

### Typography

**Primary Font:** `FiraCode Nerd Font` (19pt)

- Ligatures support for better code readability
- Complete Nerd Font icon set
- Crisp rendering at any size

**Italic Font:** `MonoLisa`

- Beautiful italics for comments and emphasis
- Professional and readable

### Visual Effects

| Effect | Value | Description |
|--------|-------|-------------|
| **Background Opacity** | 97% | Subtle transparency |
| **Background Blur** | 5px | Soft blur effect |
| **Custom Shader** | `cursor_sweep.glsl` | Animated cursor effect |

---

## ⚙️ Configuration Details

### Window Settings

```
window-width  = 110    # Columns
window-height = 35     # Rows
```

Perfect size for:

- Side-by-side code editing
- Terminal multiplexing with tmux
- Comfortable reading without scrolling

### Input Behavior

| Setting | Value | Purpose |
|---------|-------|---------|
| `mouse-hide-while-typing` | `true` | Cleaner view while coding |
| `macos-option-as-alt` | `true` | Enable Alt shortcuts on macOS |

---

## 🎯 Custom Shader

### Cursor Sweep Effect

**File:** `cursor_sweep.glsl`

A custom GLSL shader that creates a beautiful cursor animation effect:

- Smooth cursor transitions
- GPU-accelerated rendering
- Non-intrusive visual feedback
- Professional appearance

**Location:** `~/.dotfiles/ghostty/cursor_sweep.glsl`

---

## 🚀 Installation

### 1. Install Ghostty

**macOS:**

```bash
brew install ghostty
```

**From Source:**

Visit [ghostty.org](https://ghostty.org) for installation instructions.

### 2. Install Required Fonts

**FiraCode Nerd Font:**

```bash
brew tap homebrew/cask-fonts
brew install font-fira-code-nerd-font
```

**MonoLisa** (optional, for italics):

Purchase and install from [monolisa.dev](https://www.monolisa.dev)

### 3. Symlink Configuration

```bash
# Create config directory
mkdir -p ~/.config/ghostty

# Symlink config file
ln -s ~/.dotfiles/ghostty/config ~/.config/ghostty/config

# Symlink shader
ln -s ~/.dotfiles/ghostty/cursor_sweep.glsl ~/.config/ghostty/cursor_sweep.glsl
```

### 4. Restart Ghostty

Close and reopen Ghostty to apply the configuration.

---

## 🎨 Customization

### Change Font Size

```bash
# Edit config
font-size = 16  # Smaller
font-size = 22  # Larger
```

### Adjust Transparency

```bash
# More transparent
background-opacity = 0.90
background-blur = 10

# Less transparent
background-opacity = 0.99
background-blur = 2

# Fully opaque
background-opacity = 1.0
background-blur = 0
```

### Disable Custom Shader

```bash
# Comment out or remove
# custom-shader = ~/.dotfiles/ghostty/cursor_sweep.glsl
```

### Change Theme

```bash
# Other Catppuccin variants
theme = "Catppuccin Latte"   # Light mode
theme = "Catppuccin Frappe"  # Mid-tone
theme = "Catppuccin Macchiato"  # Darker

# Other themes
theme = "Nord"
theme = "Dracula"
theme = "Gruvbox"
```

### Adjust Window Size

```bash
# Smaller window
window-width = 90
window-height = 30

# Larger window
window-width = 130
window-height = 40

# Fullscreen on launch
# (Add to config)
window-fullscreen = true
```

---

## 🖼️ Perfect Pairings

This Ghostty configuration works beautifully with:

| Tool | Purpose | Why it fits |
|------|---------|-------------|
| **Tmux** | Terminal multiplexer | Transparent background shows through |
| **Neovim** | Text editor | Matching Catppuccin Mocha theme |
| **Nushell** | Modern shell | Starship prompt looks crisp |
| **Starship** | Shell prompt | Icons render perfectly with Nerd Font |

---

## 🎯 Why Ghostty?

**Performance:**

- GPU-accelerated rendering
- Lower latency than Alacritty or Kitty
- Smooth animations and effects

**Features:**

- Native macOS integration
- Custom shader support
- Modern architecture
- Active development

**Appearance:**

- True transparency with blur
- Font rendering excellence
- Theme flexibility
- Professional aesthetics

---

## 📊 Performance

| Metric | Value | Comparison |
|--------|-------|------------|
| **Startup Time** | ~50ms | Faster than iTerm2 |
| **Input Latency** | <10ms | On par with Alacritty |
| **GPU Usage** | Low | Efficient rendering |
| **Memory** | ~50MB | Lightweight |

---

## 📚 Resources

- [Ghostty Official Site](https://ghostty.org)
- [Ghostty Documentation](https://ghostty.org/docs)
- [Catppuccin Ghostty](https://github.com/catppuccin/ghostty)
- [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads)
- [GLSL Shader Reference](https://www.khronos.org/opengl/wiki/Core_Language_(GLSL))

---

<div align="center">

Crafted in Middle-Stack ⚔️ for terminal perfection

*Part of [dotfiles](../..) collection*

</div>
