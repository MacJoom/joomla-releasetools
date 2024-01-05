repoowner="MacJoom"
repository="https://github.com//$repoowner/joomla-cms.git"
#repository="https://github.com//MacJoom/joomla-cms.git"
joomladir="joomla-cms"
minversion="4"
majversion="4"
patchversion="2"
oldextra=""
oldextranum=""
extra="rc"
extranum="1"
extranext="rc"
extranumnext="2"
codename="Pamoja"
reldate="2024-01-03 15:00"
revdate="2024-01-03 15:01"
checkout="$majversion.$minversion-dev"
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

