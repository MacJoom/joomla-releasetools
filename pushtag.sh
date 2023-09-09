#!/bin/bash
. globals.sh
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
export GPG_TTY=$(tty)
cd joomla-cms
git status
git branch -v
echo "Tags:"
git tag -n -l $majversion.$minversion.$patchversion*
read -p "Press any key to push tags..."
git push --tags
