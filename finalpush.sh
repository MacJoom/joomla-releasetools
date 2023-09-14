#!/bin/bash
. globals.sh
echo "Repository: $repository"
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
export GPG_TTY=$(tty)
cd joomla-cms
git status
git branch -v
read -p "Press any key to do the final push..."
git push

