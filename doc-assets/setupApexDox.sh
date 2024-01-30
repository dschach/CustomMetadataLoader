#!/bin/sh

# Run this BEFORE running ApexDox so all your files are set up properly.

printf '<link href="assets/styling.css" rel="stylesheet" />' > "doc-assets/main.html"
echo >> "doc-assets/main.html"
npx marked -i README.md --gfm >> "doc-assets/main.html"

printf '<link href="assets/styling.css" rel="stylesheet" />' > "doc-assets/files/changelog.html"
echo >> "doc-assets/files/changelog.html"
npx marked -i CHANGELOG.md --gfm >> "doc-assets/files/changelog.html"
sed -i "" "s|CHANGELOG.md|changelog.html|" "doc-assets/main.html"

printf '<link href="assets/styling.css" rel="stylesheet" />' > "doc-assets/files/installation.html"
echo >> "doc-assets/files/installation.html"
npx marked -i INSTALLATION.md --gfm >> "doc-assets/files/installation.html"
sed -i "" "s|INSTALLATION.md|installation.html|" "doc-assets/main.html"

npm run updateHighlight