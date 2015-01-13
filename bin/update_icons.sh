#!/bin/sh
# This requires "imagemin", install via:
# npm install --global imagemin

echo "Cleaning up..."
rm -rvf app/assets/images/icons
mkdir app/assets/images/icons

echo "Optimizing SVG..."
imagemin icons/*.svg app/assets/images/icons

ruby bin/generate-icons-helper
