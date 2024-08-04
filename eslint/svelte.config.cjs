module.exports = {
    "parserOptions": {
      "parser": "@typescript-eslint/parser",
      "ecmaVersion": "latest",
      "sourceType": "module",
      "tsconfigRootDir": __dirname
    },
    "ignorePatterns": ["node_modules", ".eslintrc.cjs", "*.json", "build", ".svelte-kit"],
    "extends": [
      "airbnb-base",
      "plugin:svelte/recommended",
      "plugin:prettier/recommended"
    ],
    "plugins": [
      "@typescript-eslint",
      "prettier"
    ],
    "rules": {}
}
