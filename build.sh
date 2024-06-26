#!/bin/bash
. globals.sh
read -p "Press any key to start..."
export GPG_TTY=$(tty)
rm -rf joomla-cms
git clone $repository
cd joomla-cms
git checkout $checkout
git fetch
git pull
#read -p "Press any key to create branch ..."
#git branch $branch
#git switch $branch
cp -rf ../config.git.$repoowner .git/config
#read -p "Press any key to push branch ..."
#git push --set-upstream origin $branch
read -p "Press any key to start build/bump ..."
echo "php build/bump.php -v $tag -c $codename -d \"$reldate\""
php build/bump.php -v $tag -c $codename -d "$reldate"
git commit -am "$commit"
git tag -s -m "$commit" $tag
read -p "Press any key to start build/build ..."
php build/build.php
