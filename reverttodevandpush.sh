#!/bin/bash
. globals.sh
echo "Repository: $repository"
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
echo "Revdate: $revdate"
export GPG_TTY=$(tty)
cd joomla-cms
read -p "Press 'enter' to build revert to dev ..."
php build/bump.php -v $next-dev -d "$revdate"
git add .
git commit -s -m "Revert to dev"
read -p "Press any to push ..."
git push
