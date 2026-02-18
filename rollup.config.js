import resolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";

const plugins = [
  resolve(), // tells Rollup how to find date-fns in node_modules
  commonjs(), // converts date-fns to ES modules
];

export default [
  {
    input: "./lib/web/app.js",
    output: {
      dir: "priv/static/assets",
      format: 'umd',
    },
    plugins: plugins,
  }
];
