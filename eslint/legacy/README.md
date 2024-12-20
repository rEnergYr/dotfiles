# ESLint

My ESLint/Prettier config with typescript

## Directory & file structure

```
📂 legacy
┣ 📜 adonisjs.config.cjs (prettier/airbnb)
┣ 📜 nuxt.config.cjs (prettier/airbnb)
┣ 📜 svelte.config.cjs (prettier/airbnb)
┗ 📜 tsapp.config.cjs (prettier/airbnb)
```

## TypeScript app

Add packages as dev dependencies

```shell
yarn add -D eslint@8.57.0 prettier eslint-plugin-import eslint-config-airbnb-base eslint-config-airbnb-typescript eslint-config-prettier eslint-plugin-prettier typescript-eslint globals
```

## Nuxt (v3)

Add packages as dev dependencies

```shell
yarn add -D eslint@8.57.0 eslint-plugin-vue eslint-plugin-nuxt vite-plugin-eslint typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser @nuxtjs/eslint-config-typescript prettier eslint-config-prettier eslint-plugin-prettier eslint-config-airbnb-base eslint-plugin-import
```

## Svelte (v4)

Add packages as dev dependencies

```shell
yarn add -D eslint@8.57.0 prettier eslint-plugin-import eslint-config-airbnb-base eslint-config-airbnb-typescript eslint-config-prettier eslint-plugin-prettier typescript-eslint globals eslint-plugin-svelte prettier-plugin-svelte
```

## Adonisjs (v5)

Add packages as dev dependencies

```shell
yarn add -D eslint@8.57.0 eslint-plugin-import eslint-config-airbnb-base eslint-config-airbnb-typescript
```
