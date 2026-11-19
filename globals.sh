repoowner="joomla"
#repoowner="MacJoom"
repository="https://github.com//$repoowner/joomla-cms.git"
#repository="https://github.com//MacJoom/joomla-cms.git"
joomladir="joomla-cms"
majversion="6"
minversion="2"
patchversion="1"
oldmajversion=""
oldminversion=""
oldpatchversion=""
oldextra=""
oldextranum=""
extra="rc"
extranum="1+security"
extranext="rc"
extranumnext="2"
codename="Mwezi"
reldate="2026-11-18 10:00"
revdate="2026-11-18 10:01"
previoustag="6.2.0"
checkout="$majversion.$minversion-dev"
infourl="https://github.com/joomla/joomla-cms/releases/tag/6.2.1-rc1"
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
upmergeMin=4
upmergeMaj=5
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
echo "PreviousBranch: $previoustag for github text"
