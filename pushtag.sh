#!/bin/bash
# Push the signed release tag $tag, so the GitHub release can be created from it.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

enter_dir "$CMS_DIR"
git status
git branch -v
echo "Tags:"
git tag -n -l "$version*"
git rev-parse -q --verify "refs/tags/$tag" >/dev/null || die "tag $tag does not exist"
pause "Next: push tag $tag to origin."
run git push origin "refs/tags/$tag"
