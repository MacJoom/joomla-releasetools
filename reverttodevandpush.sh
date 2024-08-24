#!/bin/bash
. globals.sh
export GPG_TTY=$(tty)
cd joomla-cms
read -p "Press 'enter' to build revert to dev ..."
#php build/bump.php -v $next-dev -d "$revdate"
php build/bump.php -v 4.4.9-dev -d "$revdate"
git add .
read -p "Press any to commit ..."
git commit -s -m "Revert to dev"
read -p "Press any to push ..."
git push
