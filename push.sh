#!/bin/bash
stage="alpha"
stagenum="3"
minversion="4"
majversion="4"
patchversion="0"
extra="alpha"
extranum="3"
extranext="beta"
extranumnext="1"
codename="Pamoja"
reldate="2023-07-25 16:00"
revdate="2023-07-25 16:01"
checkout="$majversion.$minversion-dev"
branch="$majversion.$minversion.$patchversion-$extra"
tag="$majversion.$minversion.$patchversion-$extra$extranum"
commit="Joomla! $majversion.$minversion.$patchversion ${extra^} $extranum"
next="$majversion.$minversion.$patchversion-$extranext$extranumnext"
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
export GPG_TTY=$(tty)
cd joomla-cms
read -p "Press any key to push branch and tags ..."
git push 
git push --tags

