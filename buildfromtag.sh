#!/bin/bash
# Resume in the existing clone at the tag step (the bump commit already exists): tag, build.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

enter_dir "$CMS_DIR"
git status
pause "Next: create signed tag $tag."
run git tag -s -m "$commit" "$tag"
build_packages
