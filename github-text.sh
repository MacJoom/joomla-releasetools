#!/bin/bash
# Generate the GitHub release notes into joomla-github-text/github_release.txt.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

pause "Generate the GitHub release text for $tag (previous: $previoustag)."
[[ -n $previoustag ]] || die "previoustag is not set in $GLOBALS"
enter_dir joomla-github-text
echo "+ php github-text.php --tag=$tag --previous-tag=$previoustag --release-page=$infourl > github_release.txt"
php github-text.php --tag="$tag" --previous-tag="$previoustag" --release-page="$infourl" > github_release.txt
echo "Written: $PWD/github_release.txt"
