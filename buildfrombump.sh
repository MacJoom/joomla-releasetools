#!/bin/bash
# Resume in the existing clone at the bump step: bump, commit, tag, build (e.g. after secmerge.sh).
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

enter_dir "$CMS_DIR"
git status
bump_release
git add .
commit_and_tag
build_packages
