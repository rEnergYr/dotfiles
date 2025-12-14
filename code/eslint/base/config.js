import js from "@eslint/js";
import tsParser from "@typescript-eslint/parser";
import eslintConfigPrettier from "eslint-config-prettier";
import eslintPluginImportSort from "eslint-plugin-simple-import-sort";
import turboPlugin from "eslint-plugin-turbo";
import globals from 'globals';

/**
 * A shared ESLint configuration for the repository.
 *
 * @type {import("eslint").Linter.Config}
 * */
export const config = [
  js.configs.recommended,
  eslintConfigPrettier,
  {
    languageOptions: {
      globals: {
        ...globals.node,
      },
      parserOptions: {
        parser: tsParser,
      },
    },
    plugins: {
      turbo: turboPlugin,
      "simple-import-sort": eslintPluginImportSort,
    },
    rules: {
      "turbo/no-undeclared-env-vars": "warn",
      "simple-import-sort/imports": "error",
      "simple-import-sort/exports": "error",
      "prettier/prettier": [
        "error",
        {
          trailingComma: "es5",
          semi: false,
          singleQuote: true,
          useTabs: false,
          quoteProps: "consistent",
          bracketSpacing: true,
          arrowParens: "always",
          printWidth: 100,
        },
      ],
    },
  },
  {
    ignores: ["node_modules/**"],
  },
];
