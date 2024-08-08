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
    "ignorePatterns": ["node_modules", ".eslintrc.cjs", "*.json", "build", ".svelte-kit"],
    "extends": [
      "plugin:@typescript-eslint/recommended",
      "airbnb-base",
      "plugin:svelte/recommended",
      "plugin:prettier/recommended"
    ],
    "plugins": [
      "prettier"
    ],
    "rules": {}
}
