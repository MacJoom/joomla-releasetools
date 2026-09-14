repoowner="joomla"
#repoowner="MacJoom"
repository="https://github.com//$repoowner/joomla-cms.git"
#repository="https://github.com//MacJoom/joomla-cms.git"
joomladir="joomla-cms"
majversion="6"
minversion="2"
patchversion="0"
oldmajversion=""
oldminversion=""
oldpatchversion=""
oldextra=""
oldextranum=""
extra="beta"
extranum="3"
extranext="beta"
extranumnext="4"
codename="Mwezi"
reldate="2026-09-15 18:00"
revdate="2026-09-15 18:01"
checkout="$majversion.$minversion-dev"
infourl="https:\/\/developer.joomla.org\/news\/1080-joomla-6-2-beta-3-preparing-for-the-stable.html"
#infourl="https:\/\/developer.joomla.org\/news\/1079-joomla-6-2-beta-2-test-test-test.html"
if [ -z "$extra" ]
then
    branch="$majversion.$minversion.$patchversion-stable"
    tag="$majversion.$minversion.$patchversion"
    commit="Joomla! $majversion.$minversion.$patchversion Stable"
    nextpatchversion=$((patchversion+1))
    next="$majversion.$minversion.$nextpatchversion"
else
    branch="$majversion.$minversion.$patchversion-$extra"
    tag="$majversion.$minversion.$patchversion-$extra$extranum"
    commit="Joomla! $majversion.$minversion.$patchversion ${extra^} $extranum"
    next="$majversion.$minversion.$patchversion-$extranext$extranumnext"
fi

if (( minversion > 0 )); then
    upmergeMaj=$majversion
    upmergeMin=$((minversion - 1))
else
    upmergeMaj=$((majversion - 1))
    upmergeMin=4
fi

upmergeBranch="${upmergeMaj}.${upmergeMin}-dev"

echo "Repository: $repository"
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Upmerge-Branch: $upmergeBranch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
echo "Release Date: $reldate"
echo "Revert to Dev Date: $revdate"
echo "Infourl: $infourl"
echo "Codename: $codename"
echo "UpmergeBranch: $upmergeBranch"
