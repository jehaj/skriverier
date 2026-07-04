#!/usr/bin/env bash
#
# clear-gps-exif.sh
#
# Recursively finds image files inside a git repository and strips GPS
# metadata from them in place, but only touches files that actually
# contain GPS data (checked first, per-file, before any write).
#
# Requires: exiftool, git
#
# Usage:
#   ./clear-gps-exif.sh [OPTIONS] [PATH]
#
#   PATH   Directory to start from (default: current directory).
#          The script walks up from PATH to find the enclosing git repo.
#
# Options:
#   -n, --dry-run         Only report which files have GPS data; don't modify anything.
#   -v, --verbose         Print every file checked (not just ones with GPS).
#   -a, --all             Also process untracked files that are gitignored
#                         (default: tracked files + untracked-but-not-ignored files).
#   -q, --quiet           Only print a final summary line.
#   -h, --help            Show this help.
#
# Exit codes: 0 = success, 1 = usage/environment error.

set -euo pipefail

# ---------------------------------------------------------------------------
# Defaults / arg parsing
# ---------------------------------------------------------------------------
DRY_RUN=0
VERBOSE=0
QUIET=0
INCLUDE_IGNORED=0
TARGET_PATH="."

usage() {
    sed -n '2,25p' "$0" | sed 's/^# \{0,1\}//'
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--dry-run) DRY_RUN=1; shift ;;
        -v|--verbose) VERBOSE=1; shift ;;
        -a|--all) INCLUDE_IGNORED=1; shift ;;
        -q|--quiet) QUIET=1; shift ;;
        -h|--help) usage; exit 0 ;;
        --) shift; break ;;
        -*)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
        *)
            TARGET_PATH="$1"
            shift
            ;;
    esac
done

# ---------------------------------------------------------------------------
# Sanity checks
# ---------------------------------------------------------------------------
command -v exiftool >/dev/null 2>&1 || {
    echo "Error: exiftool is not installed. Install it (e.g. 'apt install libimage-exiftool-perl' or 'brew install exiftool')." >&2
    exit 1
}
command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed." >&2
    exit 1
}

if [[ ! -d "$TARGET_PATH" ]]; then
    echo "Error: '$TARGET_PATH' is not a directory." >&2
    exit 1
fi

REPO_ROOT="$(git -C "$TARGET_PATH" rev-parse --show-toplevel 2>/dev/null)" || {
    echo "Error: '$TARGET_PATH' is not inside a git repository." >&2
    exit 1
}

# ---------------------------------------------------------------------------
# Recognized image extensions (case-insensitive).
# Covers common raster/web formats plus a handful of camera raw formats
# that carry GPS EXIF/XMP too. Extend this list as needed.
# ---------------------------------------------------------------------------
IMAGE_EXTS=(
    jpg jpeg jpe jfif
    png
    webp
    avif
    jxl
    heic heif
    tif tiff
    gif
    bmp
    dng cr2 cr3 nef arw rw2 orf raf pef srw
)

is_image_file() {
    local f="$1"
    local ext="${f##*.}"
    ext="${ext,,}" # lowercase
    [[ "$ext" == "$f" ]] && return 1 # no extension
    local e
    for e in "${IMAGE_EXTS[@]}"; do
        [[ "$ext" == "$e" ]] && return 0
    done
    return 1
}

# ---------------------------------------------------------------------------
# GPS check: looks at the standard EXIF GPS group *and* any XMP tags whose
# name starts with GPS (some tools only write location into XMP, not EXIF).
# Returns 0 (true) if any GPS-related tag is present with a value.
# ---------------------------------------------------------------------------
has_gps() {
    local f="$1"
    local out
    out="$(exiftool -m -s3 -gps:all -xmp:gps\* "$f" 2>/dev/null || true)"
    [[ -n "$(echo "$out" | tr -d '[:space:]')" ]]
}

# ---------------------------------------------------------------------------
# Strip GPS: removes the EXIF GPS group, XMP GPS-prefixed tags, and the
# XMP "geotag" pseudo-tag (exiftool's documented combo for fully clearing
# geolocation: `exiftool -gps:all= -xmp:geotag= file`). -overwrite_original
# means no ORIGINAL backup file is left behind, per "in place" requirement.
# -P preserves the file's modification date/time.
# ---------------------------------------------------------------------------
strip_gps() {
    local f="$1"
    exiftool -m -P -overwrite_original \
        -gps:all= \
        -xmp:gps\*= \
        -xmp:geotag= \
        "$f" >/dev/null
}

# ---------------------------------------------------------------------------
# Build the file list from git, so we respect .gitignore by default and
# never touch .git internals. Includes:
#   - tracked files
#   - untracked files not covered by .gitignore
# With --all, also includes untracked-but-ignored files.
# ---------------------------------------------------------------------------
git_list_args=(-z --cached --others)
if [[ "$INCLUDE_IGNORED" -eq 0 ]]; then
    git_list_args+=(--exclude-standard)
fi

checked=0
found=0
cleaned=0
errors=0

log() { [[ "$QUIET" -eq 0 ]] && echo "$@"; return 0; }
vlog() { [[ "$VERBOSE" -eq 1 && "$QUIET" -eq 0 ]] && echo "$@"; return 0; }

log "Repo: $REPO_ROOT"
[[ "$DRY_RUN" -eq 1 ]] && log "Mode: dry-run (no files will be modified)"
log ""

while IFS= read -r -d '' rel_path; do
    is_image_file "$rel_path" || continue

    abs_path="$REPO_ROOT/$rel_path"
    [[ -f "$abs_path" ]] || continue

    checked=$((checked + 1))
    vlog "checking: $rel_path"

    if has_gps "$abs_path"; then
        found=$((found + 1))
        if [[ "$DRY_RUN" -eq 1 ]]; then
            log "GPS found (dry-run, not modified): $rel_path"
        else
            if strip_gps "$abs_path"; then
                cleaned=$((cleaned + 1))
                log "GPS removed: $rel_path"
            else
                errors=$((errors + 1))
                log "ERROR removing GPS: $rel_path" >&2
            fi
        fi
    fi
done < <(git -C "$REPO_ROOT" ls-files "${git_list_args[@]}")

log ""
log "Checked: $checked image file(s)"
log "With GPS data: $found"
if [[ "$DRY_RUN" -eq 0 ]]; then
    log "Cleaned: $cleaned"
    [[ "$errors" -gt 0 ]] && log "Errors: $errors"
fi

[[ "$errors" -gt 0 ]] && exit 1
exit 0
