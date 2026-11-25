#!/bin/bash
# Legacy release-branch flow: fresh clone of the already pushed $branch, then bump, commit, tag, build.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

pause "Start the release build from branch $branch."
require_git_config "$repoowner"
clone_fresh "$CMS_DIR" "$branch"
install_git_config "$repoowner"
bump_release
commit_and_tag
build_packages
