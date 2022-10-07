# Eslint

My eslint config for

- [Nuxt 3](https://v3.nuxtjs.org/)
- [Adonisjs](https://adonisjs.com/)

## Directory & file structure

```
📂 Workflows
┗ 📜 nuxt3.config.json (prettier/airbnb)
```

## Nuxt 3

Add packages as dev dependencies

```shell
yarn add -D eslint eslint-plugin-vue eslint-plugin-nuxt vite-plugin-eslint typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser @nuxtjs/eslint-config-typescript prettier eslint-config-prettier eslint-plugin-prettier
```

Init eslint config

```shell
yarn create @eslint/config
```

## Airbnb JS Style Guide into Adonisjs

Add packages as dev dependencies

```shell
yarn add -D eslint-plugin-import eslint-config-airbnb-base eslint-config-airbnb-typescript
```

Add packages at end of extends

```json
{
  "extends": [
    "airbnb-base",
    "airbnb-typescript/base", 
    "prettier"
  ]
}
```
