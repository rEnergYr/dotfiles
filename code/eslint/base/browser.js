import globals from 'globals';
import { config as baseConfig } from "./config.js";
import tseslint from "typescript-eslint";
import eslintPluginPrettierRecommended from 'eslint-plugin-prettier/recommended';

/**
 * A custom ESLint configuration for libraries that use Browser APIs.
 *
 * @type {import("eslint").Linter.Config}
 */
export const browserConfig = [
  ...baseConfig,
  ...tseslint.configs.recommended,
  eslintPluginPrettierRecommended,
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    }
  }
];
