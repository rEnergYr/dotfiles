module.exports = {
    "parserOptions": {
      "tsconfigRootDir": __dirname
    },
    "ignorePatterns": ["build", ".eslintrc.cjs", "*.json"],
    "extends": [
      "plugin:adonis/typescriptApp",
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
