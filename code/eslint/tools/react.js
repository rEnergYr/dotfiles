import { globalIgnores } from "eslint/config";
import { browserConfig } from "../base/browser.js";
import reactHooks from 'eslint-plugin-react-hooks'
import reactRefresh from 'eslint-plugin-react-refresh'

/**
 * A custom ESLint configuration for libraries that use React.
 *
 * @type {import("eslint").Linter.Config}
 */
export const reactConfig = [
  globalIgnores(['dist']),
  ...browserConfig,
  {
    files: ['**/*.{ts,tsx}'],
    rules: {
      ...reactHooks.configs['recommended-latest'].rules,
      ...reactRefresh.configs.vite.rules,
    },
    plugins: {
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh,
    },
  },
];
