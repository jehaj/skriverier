#!/usr/bin/env bash

set -euo pipefail

PROJECT_DIR=$(dirname "$(realpath "$0")")
cd "$PROJECT_DIR"

echo "Running image optimization..."

# Detect ImageMagick version (ImageMagick 7+ uses "magick", ImageMagick 6 uses standalone commands)
if command -v magick &>/dev/null; then
    magick_identify() { magick identify "$@"; }
    magick_convert() { magick "$@"; }
else
    magick_identify() { identify "$@"; }
    magick_convert() { convert "$@"; }
fi

# Find all original JPG/PNG images in content/posts/
# Ignoring any files that are already pre-optimized (ending in -1x or -2x)
find content/posts/ -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) ! -name "*-1x.*" ! -name "*-2x.*" -print0 | while IFS= read -r -d '' img; do
    dir=$(dirname "$img")
    filename=$(basename "$img")
    ext="${filename##*.}"
    name="${filename%.*}"

    # Get original image width using identify
    # If the identify command fails or output is empty, skip this file
    if ! dimensions=$(magick_identify -format "%w %h" "$img" 2>/dev/null); then
        echo "Warning: Could not identify dimensions for $img. Skipping."
        continue
    fi
    
    read -r width height <<< "$dimensions"
    if [[ -z "$width" ]]; then
        echo "Warning: Empty width for $img. Skipping."
        continue
    fi

    # Target JXL paths
    jxl_1x="$dir/$name-1x.jxl"
    jxl_2x="$dir/$name-2x.jxl"

    # 1. Generate 1x JXL
    if [[ ! -f "$jxl_1x" ]]; then
        w1=800
        if (( width < 800 )); then
            w1=$width
        fi
        echo "Generating JXL (1x): $jxl_1x (${w1}px)"
        magick_convert "$img" -resize "${w1}x>" "$jxl_1x"
    fi

    # 2. Generate 2x JXL if original width > 800
    if (( width > 800 )); then
        if [[ ! -f "$jxl_2x" ]]; then
            w2=1600
            if (( width < 1600 )); then
                w2=$width
            fi
            echo "Generating JXL (2x): $jxl_2x (${w2}px)"
            magick_convert "$img" -resize "${w2}x>" "$jxl_2x"
        fi
    fi
done

echo "Image optimization finished."
