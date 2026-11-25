#!/bin/bash
# Legacy release-branch flow: create $branch from $checkout in the existing clone, PUSH it, then bump, commit, tag, build.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

pause "Start: create and push release branch $branch."
enter_dir "$CMS_DIR"
run git checkout "$checkout"
pause "Next: create branch $branch."
run git switch -c "$branch"
install_git_config "$repoowner"
pause "Next: push branch $branch to origin."
run git push --set-upstream origin "$branch"
bump_release
commit_and_tag
build_packages
