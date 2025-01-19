import globals from "globals";
import pluginJs from "@eslint/js";
import pluginReact from "eslint-plugin-react";
import pluginJest from "eslint-plugin-jest"; // Para soporte de Jest
import pluginReactHooks from "eslint-plugin-react-hooks"; // Soporte para hooks de React

/** @type {import('eslint').Linter.Config} */
const config = [
  {
    files: ["**/*.{js,mjs,cjs,jsx}"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        ...globals.browser, // Soporte para el navegador
        ...globals.node, // Soporte para Node.js
      },
      ecmaFeatures: {
        jsx: true, // Habilitar JSX
      },
    },
    plugins: {
      react: pluginReact,
      "react-hooks": pluginReactHooks,
      jest: pluginJest,
    },
    rules: {
      ...pluginJs.configs.recommended.rules, // Reglas recomendadas por ESLint
      ...pluginReact.configs.recommended.rules, // Reglas recomendadas para React
      ...pluginReactHooks.configs.recommended.rules, // Reglas recomendadas para React Hooks
      ...pluginJest.configs.recommended.rules, // Reglas recomendadas para Jest
      "react/react-in-jsx-scope": "off", // React 17+ no requiere importar React
      "react/jsx-no-target-blank": "warn", // Seguridad para enlaces
    },
  },
];

export default config;
