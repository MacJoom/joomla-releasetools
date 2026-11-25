#!/bin/bash
# Push the current branch of the clone (if the push in reverttodevandpush.sh was skipped).
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

enter_dir "$CMS_DIR"
git status
git branch -v
pause "Next: git push."
run git push
