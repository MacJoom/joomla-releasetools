repoowner="joomla"
repository="https://github.com//$repoowner/joomla-cms.git"
#repository="https://github.com//MacJoom/joomla-cms.git"
joomladir="joomla-cms"
majversion="4"
minversion="4"
patchversion="8"
oldmajversion="4"
oldminversion="4"
oldpatchversion="7"
oldextra=""
oldextranum=""
extra=""
extranum=""
extranext=""
extranumnext=""
codename="Pamoja"
reldate="2024-08-27 16:00"
revdate="2024-08-27 16:01"
checkout="$majversion.$minversion-dev"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5910-joomla-5-1-3-and-joomla-4-4-7-are-here.html"
#infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5910-joomla-5-1-3-and-4-4-7-security-and-bug-fix-release.html"
infourl="https:\/\/www.joomla.org\/announcements\/release-news\/5911-joomla-5-1-4-and-joomla-4-4-8-are-here.html"
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

echo "Repository: $repository"
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
echo "Release Date: $reldate"
echo "Revert to Dev Date: $revdate"
echo "Infourl: $infourl"
