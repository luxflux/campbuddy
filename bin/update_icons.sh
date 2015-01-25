#!/bin/sh
# This requires "imagemin", install via:
# npm install svgo

set -e

echo "Cleaning up..."
rm -rvf app/assets/images/icons
mkdir app/assets/images/icons

echo "Optimizing SVG..."
svgo -f icons/ -o app/assets/images/icons/ --disable convertShapeToPath --disable collapseGroups

echo "Removing fill attributes"
sed -i '' 's/ fill="none"//g' app/assets/images/icons/*.svg

echo "Generating helper"
ruby bin/generate-icons-helper
