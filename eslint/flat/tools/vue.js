import eslintPluginVue from 'eslint-plugin-vue';
import { browserConfig } from "../base/browser.js";

/**
 * A custom ESLint configuration for libraries that use Vue.js.
 *
 * @type {import("eslint").Linter.Config}
 */
export const nuxtConfig = [
  ...browserConfig,
  ...eslintPluginVue.configs['flat/recommended'],
  {
    ignores: [".nuxt/**", ".output/**"],
  }
];
