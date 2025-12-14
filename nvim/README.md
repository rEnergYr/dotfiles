<div align="center">

# ✏️ Neovim Configuration

*A modern, fast, and beautiful Neovim setup powered by Lazy.nvim*

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-1e1e2e.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
[![Lazy.nvim](https://img.shields.io/badge/Plugin_Manager-Lazy.nvim-1e1e2e.svg?style=for-the-badge)](https://github.com/folke/lazy.nvim)
[![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin_Mocha-1e1e2e.svg?style=for-the-badge)](https://github.com/catppuccin/nvim)

</div>

---

## 🌟 Features

- 🚀 **Blazing Fast** - Optimized with lazy loading via `lazy.nvim`
- 🎨 **Beautiful UI** - Catppuccin Mocha theme with transparent background
- 🤖 **AI-Powered** - GitHub Copilot integration for intelligent code completion
- 📦 **LSP Ready** - Full Language Server Protocol support with Mason
- 🔍 **Smart Completion** - Blink completion engine with snippets
- 🎯 **Productivity** - Enhanced statusline, bufferline, and dashboard
- 🐳 **Docker & SQL** - Built-in LazyDocker and LazySQL integrations
- 📊 **Time Tracking** - WakaTime integration for coding statistics
- 🎵 **Media Integration** - Real-time music playback in statusline

---

## 📦 Plugin List

### 🎨 Theme & UI

| Plugin | Description |
|--------|-------------|
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | Soothing pastel theme with transparent background |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Blazing fast and customizable statusline with media player integration |
| [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Beautiful buffer/tab line with LSP diagnostics |
| [folke/snacks.nvim](https://github.com/folke/snacks.nvim) | Dashboard, notifier, and indent guides |
| [folke/noice.nvim](https://github.com/folke/noice.nvim) | Enhanced UI for messages, cmdline and popups |

### ⚡ Completion & Snippets

| Plugin | Description |
|--------|-------------|
| [saghen/blink.cmp](https://github.com/saghen/blink.cmp) | Performant, batteries-included completion engine |
| [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Preconfigured snippets for various languages |

### 🛠️ LSP & Diagnostics

| Plugin | Description |
|--------|-------------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Neovim LSP |
| [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim) | Portable package manager for LSP servers, DAP servers, linters, and formatters |
| [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Bridge mason.nvim with nvim-lspconfig |
| [nvimtools/none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) | Use Neovim as a language server for linting and formatting |
| [jay-babu/mason-null-ls.nvim](https://github.com/jay-babu/mason-null-ls.nvim) | Bridge mason.nvim with none-ls |
| [rachartier/tiny-code-action.nvim](https://github.com/rachartier/tiny-code-action.nvim) | Tiny and fast code action UI |

**Installed LSP Servers:**

- `lua_ls` - Lua
- `rust_analyzer` - Rust
- `ts_ls` - TypeScript/JavaScript
- `eslint` - ESLint
- `html` - HTML
- `tailwindcss` - Tailwind CSS
- `marksman` - Markdown
- `yamlls` - YAML
- `jsonls` - JSON
- `docker_language_server` - Docker

**Installed Formatters & Linters:**

- `stylua` - Lua formatter
- `markdownlint` - Markdown linter
- `yamlfix` - YAML formatter

### 🌳 Syntax & Parsing

| Plugin | Description |
|--------|-------------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Advanced syntax highlighting and code understanding |

**Installed Parsers:**

- Lua, Rust, JavaScript, TypeScript, TSX
- HTML, CSS, YAML, HJSON, TOML
- JSDoc, Dockerfile

### 🤖 AI & Copilot

| Plugin | Description |
|--------|-------------|
| [github/copilot.vim](https://github.com/github/copilot.vim) | GitHub Copilot integration for AI-powered suggestions |

### 🔧 Auto Features

| Plugin | Description |
|--------|-------------|
| [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto close and rename HTML/JSX tags using Treesitter |
| [m4xshen/autoclose.nvim](https://github.com/m4xshen/autoclose.nvim) | Auto close brackets, quotes, and more |

### 🐳 DevOps & Database

| Plugin | Description |
|--------|-------------|
| [crnvl96/lazydocker.nvim](https://github.com/crnvl96/lazydocker.nvim) | Manage Docker containers and images from Neovim |
| [LostbBlizzard/lazysql.nvim](https://github.com/LostbBlizzard/lazysql.nvim) | Database management UI |

### 🎯 Productivity

| Plugin | Description |
|--------|-------------|
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | Display available keybindings in popup (Helix preset) |
| [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime) | Automatic time tracking and metrics |

### 📚 Dependencies

| Plugin | Description |
|--------|-------------|
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Lua utility functions |
| [MunifTanjim/nui.nvim](https://github.com/MunifTanjim/nui.nvim) | UI component library |
| [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |
| [nvimtools/none-ls-extras.nvim](https://github.com/nvimtools/none-ls-extras.nvim) | Extra sources for none-ls |

---

## ⚙️ Installation

1. **Backup your current Neovim configuration**

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Symlink this configuration**

   ```bash
   ln -s ~/.dotfiles/nvim ~/.config/nvim
   ```

3. **Launch Neovim**

   ```bash
   nvim
   ```

   Lazy.nvim will automatically install all plugins on first launch.

4. **Setup GitHub Copilot**

   ```vim
   :Copilot setup
   ```

   Follow the authentication flow to enable AI-powered code completion.

5. **Setup WakaTime** (optional)

   ```vim
   :WakaTimeApiKey
   ```

   Then visit [wakatime.com/dashboard](https://wakatime.com/dashboard) to view your stats.

---

## 🎨 Theme

This configuration uses the **Catppuccin Mocha** theme with:

- ✨ Transparent background
- 🎭 Italic comments, keywords, and types
- 🪟 Transparent floating windows
- 🎯 Consistent color scheme across all plugins

---

## ⌨️ Key Features

- **Statusline** shows:
  - Current mode
  - Now playing music with play/pause icon
  - Copilot status (clickable)
  - Active LSP server (clickable)
  - Current time
  
- **Dashboard** with custom ASCII art logo
- **Smart notifications** for LSP actions and events
- **Indent guides** for better code readability
- **Buffer management** with LSP diagnostics
- **Code actions** with minimal UI

---

## 📁 Structure

```
nvim/
├── init.lua              # Entry point
├── lazy-lock.json        # Plugin lockfile
├── lua/
│   ├── config/          # Core configuration
│   │   ├── lazy.lua     # Lazy.nvim setup
│   │   ├── settings.lua # Neovim settings
│   │   └── keymaps.lua  # Key mappings
│   ├── plugins/         # Plugin configurations
│   └── utils/           # Utility functions
└── README.md            # This file
```

---

## 🚀 Performance

- Fast startup time thanks to lazy loading
- Optimized LSP configuration
- Minimal UI overhead
- Smart caching and memoization

---

<div align="center">

Crafted in Middle-Stack ⚔️ for developers who love Neovim

*Part of [dotfiles](../..) collection*

*Powered by [Lazy.nvim](https://github.com/folke/lazy.nvim)*

</div>
