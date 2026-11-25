#!/bin/bash
# Main entry point: fresh clone of $checkout, bump, commit, signed tag, build. Nothing is pushed.
# For a security release abort at the bump prompt, run secmerge.sh, then buildfrombump.sh.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

pause "Start the release build."
require_git_config "$repoowner"
clone_fresh "$CMS_DIR" "$checkout"
install_git_config "$repoowner"
bump_release
commit_and_tag
build_packages
