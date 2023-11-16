#!/bin/bash
. globals.sh
echo "Repository: $repository"
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
read -p "Press any key to start..."
export GPG_TTY=$(tty)
rm -rf joomla-cms
git clone $repository
cd joomla-cms
git checkout $checkout
cp -rf ../config.git.$repoowner .git/config
