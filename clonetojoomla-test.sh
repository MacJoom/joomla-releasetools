#!/bin/bash
. globals.sh
read -p "Press any key to start..."
export GPG_TTY=$(tty)
rm -rf joomla-test
git clone $repository joomla-test
cd joomla-test
git checkout $checkout
cp -rf ../config.git.$repoowner .git/config
