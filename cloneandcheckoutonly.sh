#!/bin/bash
. globals.sh
read -p "Press any key to start..."
export GPG_TTY=$(tty)
rm -rf joomla-cms
git clone $repository
cd joomla-cms
git checkout $checkout
cp -rf ../config.git.$repoowner .git/config
