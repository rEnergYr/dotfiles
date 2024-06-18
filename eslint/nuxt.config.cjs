module.exports = {
  "root": true,
  "env": {
    "browser": true,
    "es2022": true,
    "node": true
  },
  "parserOptions": {
    "parser": "@typescript-eslint/parser",
    "ecmaVersion": "latest",
    "sourceType": "module",
    "tsconfigRootDir": __dirname
  },
  "ignorePatterns": ["node_modules", ".nuxt", ".output", "types", ".eslintrc.cjs", "*.json"],
  "extends": [
    "@nuxtjs/eslint-config-typescript",
    "airbnb-base",
    "plugin:vue/vue3-recommended",
    "plugin:nuxt/recommended",
    "plugin:tailwindcss/recommended",
    "plugin:prettier/recommended"
  ],
  "plugins": [
    "@typescript-eslint",
    "vue",
    "nuxt",
    "prettier"
  ],
  "rules": {}
}
