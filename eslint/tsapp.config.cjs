module.exports = {
    "parserOptions": {
      "parser": "@typescript-eslint/parser",
      "project": "tsconfig.json",
      "tsconfigRootDir": __dirname
    },
    "ignorePatterns": ["node_modules", "dist", "eslint.config.js", "*.json"],
    "extends": [
      "eslint:recommended",
      "plugin:@typescript-eslint/recommended",
      "airbnb-base",
      "airbnb-typescript/base",
      "prettier"
    ],
    "plugins": [
      "prettier"
    ],
    "rules": {
      "prettier/prettier": [
        "error"
      ]
    }
  }
