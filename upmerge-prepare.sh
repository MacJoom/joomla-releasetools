#!/bin/bash
# Prepare an upmerge of $upmergeBranch into $checkout on the fork ($forkowner):
# fresh clone, show what is missing, create X.Y-upmerge-YYYY-MM-DD and merge. Push and PR by hand.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

pause "Start the upmerge of $upmergeBranch into $checkout."
require_git_config "$forkowner"
clone_fresh "$CMS_DIR"
install_git_config "$forkowner"
run git remote add upstream "$UPSTREAM_URL"
run git remote rename origin "$forkowner"
run git checkout "$checkout"
run git fetch --all --prune
run git pull
git log --oneline --merges --grep="$upmergeBranch"
pause "Next: number of commits in $checkout not in $upmergeBranch."
git rev-list --count "upstream/$upmergeBranch..upstream/$checkout"
pause "Next: commits in $upmergeBranch not yet in $checkout."
git log --oneline "upstream/$checkout..upstream/$upmergeBranch"
pause "Next: ahead/behind summary."
git rev-list --left-right --count "upstream/$checkout...upstream/$upmergeBranch"
upmerge="$majversion.$minversion-upmerge-$(date +%F)"
pause "Next: create branch $upmerge from $forkowner/$checkout."
run git checkout -b "$upmerge" "$forkowner/$checkout"
pause "Next: merge upstream/$upmergeBranch."
if run git merge upstream/"$upmergeBranch"; then
    echo "Merged without conflicts. Review, then push and open the PR."
else
    echo "Resolve the conflicts now, commit, then push and open the PR."
fi
