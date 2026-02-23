#!/bin/bash

PROJECT_DIR=$(dirname "$(realpath $0)")

# 1. Gå til projektmappen
cd $PROJECT_DIR || exit

# 2. Hent seneste ændringer fra git
git pull origin main

/usr/bin/podman run --rm \
    -v "$PROJECT_DIR":/project:Z \
    --userns=keep-id \
    ghcr.io/gohugoio/hugo:latest \
+    --cleanDestinationDir \
+    --noChmod \
+    --noTimes

echo "Hugo build færdig: $(date)"
