import { configApp } from "@adonisjs/eslint-config";
import { config as baseConfig } from "../base/config.js";

/**
 * A custom ESLint configuration for libraries that use AdonisJS.
 *
 * @type {import("eslint").Linter.Config}
 */
export const adonisJsConfig = [
  {
    ignores: ["build/**"],
  },
  ...configApp(),
  ...baseConfig,
];
