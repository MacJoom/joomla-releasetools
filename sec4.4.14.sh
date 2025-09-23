#!/bin/bash
. globals.sh
read -p "Press any key to start..."
export GPG_TTY=$(tty)
cd joomla-cms
#git fetch
#git pull
git remote add security git@github.com:joomla/cms-security.git
git remote set-url security --push no-push
git fetch security pull/636/head:636
git merge --squash 636
git commit -am 'Prepare Joomla! 4.4.14'
read -p "Press any key to start build/bump ..."
echo "php build/bump.php -v $tag -c $codename -d \"$reldate\""
php build/bump.php -v $tag -c $codename -d "$reldate"
git commit -am "$commit"
git rebase -i HEAD~3
