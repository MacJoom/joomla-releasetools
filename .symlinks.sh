#!/bin/bash
# Link every script of this repo into the parent directory (the work dir the scripts run in).
# Existing links are replaced, links to removed scripts are deleted, real files are left alone.
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)
cd "$SCRIPT_DIR/.."

for link in *.sh; do
    if [[ -L $link && $(readlink "$link") == "$SCRIPT_DIR"/* && ! -e $link ]]; then
        rm -f -- "$link"
        echo "Removed stale link: $link"
    fi
done

for script in "$SCRIPT_DIR"/*.sh; do
    name=$(basename "$script")
    [[ $name == lib.sh ]] && continue
    if [[ -e $name && ! -L $name ]]; then
        echo "Skipped (not a symlink, left alone): $name"
        continue
    fi
    ln -sfn "$script" "$name"
    echo "Linked: $name"
done
