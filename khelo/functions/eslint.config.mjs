import globals from "globals";
import js from "@eslint/js";
import google from "eslint-config-google";

export default [
  js.configs.recommended,
  google,
  {
    languageOptions: {
      ecmaVersion: 2021,
      globals: {
        ...globals.browser,
        ...globals.node,
        firebase: true,
        admin: true,
      },
    },
    rules: {
      "no-restricted-globals": ["error", "name", "length"],
      "prefer-arrow-callback": "error",
      "quotes": ["error", "double"],
      "import/no-unresolved": 0,
      "indent": ["error", 2],
      "max-len": ["error", {"code": 200}],
      "new-cap": 0,
      "require-jsdoc": 0,
      "no-extend-native": 0,
      "camelcase": 0,
    },
  },
  {
    files: ["**/*.spec.*"],
    languageOptions: {
      globals: {
        ...globals.mocha,
      },
    },
    rules: {},
  }];
