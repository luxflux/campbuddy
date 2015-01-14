#!/bin/sh
# This requires "imagemin", install via:
# npm install svgo

echo "Cleaning up..."
rm -rvf app/assets/images/icons
mkdir app/assets/images/icons

echo "Optimizing SVG..."
svgo -f icons/ -o app/assets/images/icons/ --disable convertShapeToPath

ruby bin/generate-icons-helper
