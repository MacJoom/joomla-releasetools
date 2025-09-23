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

