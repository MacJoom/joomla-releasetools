#!/bin/bash
. globals.sh
read -p "Press any key to start..."
export GPG_TTY=$(tty)
cd joomla-cms
git fetch
git pull
git remote add security git@github.com:joomla/cms-security.git
git remote set-url security --push no-push
git fetch security pull/599/head:599
git merge --squash 599
git commit -am 'Prepare Joomla! 4.4.7'
git fetch security pull/601/head:601
git merge --squash 601
git commit -am 'Prepare Joomla! 4.4.7'
git fetch security pull/602/head:602
git merge --squash 602
git commit -am 'Prepare Joomla! 4.4.7'
git fetch security pull/606/head:606
git merge --squash 606
git commit -am 'Prepare Joomla! 4.4.7'

read -p "Press any key to start build/bump ..."
echo "php build/bump.php -v $tag -c $codename -d \"$reldate\""
php build/bump.php -v $tag -c $codename -d "$reldate"
git commit -am "$commit"
