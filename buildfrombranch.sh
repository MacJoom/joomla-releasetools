#!/bin/bash
. globals.sh
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
read -p "Press any key to start..."
export GPG_TTY=$(tty)
rm -rf joomla-cms
git clone https://github.com//joomla/joomla-cms.git
#git clone https://github.com//MacJoom/joomla-cms.git
cd joomla-cms
git checkout $branch
cp ../config.joomla .git/config
read -p "Press any key to start build/bump ..."
php build/bump.php -v $tag -c $codename -d "$reldate"
git commit -am "$commit"
git tag -s -m "$commit" $tag
read -p "Press any key to start build/build ..."
php build/build.php
