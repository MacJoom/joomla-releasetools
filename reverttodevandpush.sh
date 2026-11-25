#!/bin/bash
# After the release: bump to $next-dev, commit and push (this also pushes the release commit).
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

enter_dir "$CMS_DIR"
pause "Next: build/bump.php to $next-dev."
run php build/bump.php -v "$next-dev" -d "$revdate"
git add .
pause "Next: commit 'Reset to dev'."
run git commit -s -m "Reset to dev"
pause "Next: git push."
run git push
