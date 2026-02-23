#!/bin/bash

PROJECT_DIR=$(dirname "$(realpath $0)")

# 1. Gå til projektmappen
cd $PROJECT_DIR || exit

# 2. Hent seneste ændringer fra git
git pull origin main

/usr/bin/podman run --rm \
    -v "$PROJECT_DIR":/src:Z \
    ghcr.io/gohugoio/hugo:latest \
    --cleanDestinationDir

echo "Hugo build færdig: $(date)"
