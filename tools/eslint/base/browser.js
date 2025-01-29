import globals from 'globals';
import { config as baseConfig } from "./config.js";

/**
 * A custom ESLint configuration for libraries that use Browser APIs.
 *
 * @type {import("eslint").Linter.Config}
 */
export const browserConfig = [
  ...baseConfig,
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    }
  }
];
