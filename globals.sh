repository="https://github.com//joomla/joomla-cms.git"
#repository="https://github.com//MacJoom/joomla-cms.git"
minversion="4"
majversion="4"
patchversion="0"
oldextra="rc"
oldextranum="2"
extra=""
extranum="1"
extranext="rc"
extranumnext="2"
codename="Pamoja"
reldate="2023-10-17 16:00"
revdate="2023-10-17 16:01"
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
    tag="$majversion.$minversion.$patchversion"
    commit="Joomla! $majversion.$minversion.$patchversion ${extra^} $extranum"
    next="$majversion.$minversion.$patchversion-$extranext$extranumnext"
fi

