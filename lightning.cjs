const { bundle } = require("lightningcss");
const fs = require("fs");
const path = require("path");
const chokidar = require("chokidar");

/**
 * This script automates the process of bundling and minifying CSS files for your project using LightningCSS.
 * It performs initial builds, watches for changes in the specified directories, and rebuilds the CSS bundles accordingly.
 */

// Adjust this list to include all the CSS files you want to bundle
const entryList = ["./lib/web/app.css"];

// Standanrd output directory for the bundled CSS files in Phoenix projects
const outputDir = "./priv/static/assets";

// initial build
cleanBundle();
buildBundle();

// watcher for subsequent builds
chokidar.watch("./lib/web").on("change", () => {
  buildBundle();
});

/**
 * @param {string} entry - The main CSS file path to bundle.
 * @param {string} outputDir - The directory where the bundled file will be written.
 */
function bundleFileWithDependencies(entry, outputDir) {
  try {
    const { code } = bundle({
      filename: entry,
      minify: true,
    });

    const outputFileName = path.basename(entry); // Extract the file name
    const outputPath = path.join(outputDir, outputFileName);

    fs.writeFileSync(outputPath, code);
    console.log(`Successfully bundled: ${entry} -> ${outputPath}`);
  } catch (err) {
    console.error(`Error bundling file ${entry}:`, err);
  }
}

function buildBundle() {
  entryList.forEach((entry) => {
    bundleFileWithDependencies(entry, outputDir);
  });
}

function cleanBundle() {
  const files = fs.readdirSync(outputDir);

  files.forEach((file) => {
    const filePath = path.join(outputDir, file);
    const fileStat = fs.statSync(filePath);

    if (fileStat.isFile()) {
      fs.unlinkSync(filePath); // Delete the file
    } else if (fileStat.isDirectory()) {
      fs.rmdirSync(filePath, { recursive: true }); // Delete the directory and its contents (recursive)
    }
  });

  console.log(`Cleaned all files from directory: ${outputDir}`);
}
