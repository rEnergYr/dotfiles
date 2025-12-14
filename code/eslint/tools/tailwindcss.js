import eslintPluginBetterTailwindcss from "eslint-plugin-better-tailwindcss";
import path from "path";
import { fileURLToPath } from "url";

function getProjectPath(relativePath) {
  const __filename = fileURLToPath(import.meta.url);
  const __dirname = path.dirname(__filename);
  // Set this to the root directory of your project
  const rootDir = path.resolve(__dirname, "../go/to/your/project/root");

  return path.join(rootDir, relativePath);
}

/**
 * A custom ESLint configuration for libraries that use Tailwind CSS. 
 *
 * @type {import("eslint").Linter.Config}
 */
export const tailwindConfig = [
  {
    ...eslintPluginBetterTailwindcss.configs.recommended,
    settings:
    {
      "better-tailwindcss": {
        // Adjust the path to your Tailwind CSS entry file
        entryPoint: getProjectPath("path/to/your/index.css"),
      }
    }
  },
];
