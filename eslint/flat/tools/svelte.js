import eslintPluginSvelte from 'eslint-plugin-svelte';
import { browserConfig } from "../base/browser.js";

/**
 * A custom ESLint configuration for libraries that use Svelte.
 *
 * @type {import("eslint").Linter.Config}
 */
export const svelteConfig = [
  ...browserConfig,
  ...eslintPluginSvelte.configs['flat/recommended'],
  {
    ignores: [".svelte-kit/**"],
  }
];
