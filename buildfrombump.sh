#!/bin/bash
. globals.sh
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
read -p "Press any key to start... 1) bump 2) commit 3) tag 4) build"
export GPG_TTY=$(tty)
cd joomla-cms
git status
read -p "Press any key to start build/bump ..."
php build/bump.php -v $tag -c $codename -d "$reldate"
git commit -am "$commit"
git tag -s -m "$commit" $tag
read -p "Press any key to start build/build ..."
php build/build.php
