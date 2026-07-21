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
extra="alpha"
extranum="3"
extranext="alpha"
extranumnext="3"
codename="Mwezi"
reldate="2026-07-21 18:00"
revdate="2026-07-21 18:01"
checkout="$majversion.$minversion-dev"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5910-joomla-5-1-3-and-joomla-4-4-7-are-here.html"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5910-joomla-5-1-3-and-4-4-7-security-and-bug-fix-release.html"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5911-joomla-5-1-4-and-joomla-4-4-8-are-here.html"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5919-joomla-5-2-3-security-bugfix-release.html"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5921-joomla-5-2-5-security-bugfix-release.html"
infourl="https:\/\/developer.joomla.org\/news\/1067-joomla-6-2-alpha3-one-step-closer-to-beta.html"
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
