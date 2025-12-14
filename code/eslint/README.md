<div align="center">

# 🔍 ESLint Configuration

*Shareable ESLint configs for modern JavaScript & TypeScript projects*

[![ESLint](https://img.shields.io/badge/ESLint-9+-1e1e2e.svg?style=for-the-badge&logo=eslint)](https://eslint.org)
[![TypeScript](https://img.shields.io/badge/TypeScript-Ready-1e1e2e.svg?style=for-the-badge&logo=typescript)](https://www.typescriptlang.org)
[![Prettier](https://img.shields.io/badge/Prettier-Integrated-1e1e2e.svg?style=for-the-badge&logo=prettier)](https://prettier.io)

</div>

---

## ✨ Features

- 🚀 **Modern ESLint 9+** - Flat config format
- 📦 **Turborepo Compatible** - Optimized for monorepos
- 🎨 **Prettier Integrated** - Consistent code formatting
- 🔧 **TypeScript Ready** - Full TypeScript support
- 🌐 **Framework Configs** - React, Vue, Svelte, Nuxt, AdonisJS
- 🎯 **Import Sorting** - Automatic import organization
- ⚡ **Production Ready** - Battle-tested configurations

---

## 📦 Configurations

### 🔹 Base Configs

| Config | Description | Use Case |
|--------|-------------|----------|
| **`base/config.js`** | Core ESLint + Prettier + TypeScript | Node.js projects, libraries |
| **`base/browser.js`** | Base config + browser globals | Web applications |

**Includes:**

- ESLint recommended rules
- TypeScript parser support
- Prettier integration with custom rules
- Simple import/export sorting
- Turbo plugin for monorepo env vars
- Node.js globals

**Prettier Rules:**

```javascript
{
  trailingComma: "es5",
  semi: false,
  singleQuote: true,
  useTabs: false,
  quoteProps: "consistent",
  bracketSpacing: true,
  arrowParens: "always",
  printWidth: 100
}
```

### 🎨 Framework Configs

| Config | Framework | Features |
|--------|-----------|----------|
| **`tools/react.js`** | React + Vite | React Hooks + React Refresh |
| **`tools/vue.js`** | Vue 3 | Vue parser + recommended rules |
| **`tools/svelte.js`** | Svelte | Svelte plugin + parser |
| **`tools/adonis.js`** | AdonisJS | AdonisJS linting rules |
| **`tools/tailwindcss.js`** | Tailwind CSS | Class sorting + validation |

---

## 📁 Directory Structure

```
eslint/
├── base/
│   ├── config.js       # Core ESLint config (Node.js)
│   └── browser.js      # Browser environment config
├── tools/
│   ├── react.js        # React + Vite configuration
│   ├── vue.js          # Vue 3 configuration
│   ├── svelte.js       # Svelte configuration
│   ├── adonis.js       # AdonisJS configuration
│   └── tailwindcss.js  # Tailwind CSS utilities
└── README.md
```

---

## 🚀 Usage

### Basic Node.js Project

```javascript
// eslint.config.js
import { config } from '@dotfiles/eslint/base/config.js'

export default config
```

### React + Vite Project

```javascript
// eslint.config.js
import { reactConfig } from '@dotfiles/eslint/tools/react.js'

export default reactConfig
```

### Vue 3 Project

```javascript
// eslint.config.js
import { vueConfig } from '@dotfiles/eslint/tools/vue.js'

export default vueConfig
```

### With Tailwind CSS

```javascript
// eslint.config.js
import { browserConfig } from '@dotfiles/eslint/base/browser.js'
import { tailwindConfig } from '@dotfiles/eslint/tools/tailwindcss.js'

export default [
  ...browserConfig,
  ...tailwindConfig
]
```

---

## 🛠️ Framework-Specific Setup

### <img src="https://cdn.simpleicons.org/svelte" width="16" height="16"> Svelte

**Install dependencies:**

```bash
npm add -D prettier-plugin-svelte
```

**Add `.prettierrc`:**

```json
{
  "plugins": ["prettier-plugin-svelte"],
  "overrides": [
    {
      "files": "*.svelte",
      "options": { "parser": "svelte" }
    }
  ]
}
```

### <img src="https://cdn.simpleicons.org/nuxt" width="16" height="16"> Nuxt 3

**Install dependencies:**

```bash
npm add -D @nuxt/eslint
```

**Configure in `nuxt.config.ts`:**

```typescript
export default defineNuxtConfig({
  modules: ['@nuxt/eslint']
})
```

**Update `eslint.config.ts`:**

```typescript
import { withNuxt } from './.nuxt/eslint.config.mjs'
import { vueConfig } from '@dotfiles/eslint/tools/vue.js'

export default withNuxt(vueConfig)
```

---

## 📦 Required Dependencies

### Base Config

```json
{
  "devDependencies": {
    "@eslint/js": "^9.0.0",
    "@typescript-eslint/parser": "^8.0.0",
    "eslint": "^9.0.0",
    "eslint-config-prettier": "^9.0.0",
    "eslint-plugin-prettier": "^5.0.0",
    "eslint-plugin-simple-import-sort": "^12.0.0",
    "eslint-plugin-turbo": "^2.0.0",
    "prettier": "^3.0.0",
    "globals": "^15.0.0"
  }
}
```

### Framework-Specific

**React:**

```bash
npm add -D eslint-plugin-react-hooks eslint-plugin-react-refresh
```

**Vue:**

```bash
npm add -D eslint-plugin-vue vue-eslint-parser
```

**Svelte:**

```bash
npm add -D eslint-plugin-svelte svelte-eslint-parser prettier-plugin-svelte
```

**Tailwind CSS:**

```bash
npm add -D eslint-plugin-tailwindcss
```

---

## 🎯 Rules Overview

### Core Rules

- ✅ ESLint recommended
- ✅ Prettier formatting enforcement
- ✅ Import/export auto-sorting
- ✅ Turbo env vars validation
- ✅ TypeScript parsing

### Framework Rules

- **React**: Hooks rules + Vite fast refresh
- **Vue**: Vue 3 recommended + essential rules
- **Svelte**: Svelte best practices
- **Tailwind**: Class sorting + no-custom-classname

---

## 💡 Tips

1. **Monorepo Setup**: Use Turborepo with shared configs
2. **Editor Integration**: Install ESLint extension for VSCode/WebStorm
3. **Pre-commit Hooks**: Use lint-staged for automated linting
4. **Custom Rules**: Extend configs with your own rules

```javascript
import { config } from '@dotfiles/eslint/base/config.js'

export default [
  ...config,
  {
    rules: {
      'no-console': 'warn'
    }
  }
]
```

---

<div align="center">

Crafted in Middle-Stack ⚔️ for cleaner code

*Part of [dotfiles](../..) collection*

</div>
