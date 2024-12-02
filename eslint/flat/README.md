# ESLint

My ESLint/Prettier config with typescript

## Directory & file structure

```
📂 flat
┣ 📁 base
┃ ┣ 📜 browser.js
┃ ┗ 📜 config.js
┣ 📁 tools
┃ ┣ 📜 adonis.js
┃ ┣ 📜 svelte.js
┃ ┗ 📜 vue.js
┣ 📜 package.json
┗ 📜 README.md
```

## Svelte app

Add packages as dev dependencies

```shell
bun add -D prettier-plugin-svelte
```

Add .prettierrc file

```json
{
  plugins: ["prettier-plugin-svelte"],
  overrides: [
    {
      "files": "*.svelte",
      "options": { "parser": "svelte" }
    }
  ]
}
```

## Nuxt app

Add packages as dev dependencies

```shell
bun add -D @nuxt/eslint
```

Configure the module in `nuxt.config.ts`

```javascript
export default defineNuxtConfig({
  modules: ['@nuxt/eslint']
})
```

Update default export in `eslint.config.ts`

```javascript
import { withNuxt } from './.nuxt/eslint.config.mjs'

export default withNuxt(eslintConfig)
```
