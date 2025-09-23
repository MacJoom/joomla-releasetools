#!/bin/bash
. globals.sh
read -p "Press any key to start... 1) tag 2) build"
export GPG_TTY=$(tty)
cd joomla-cms
git status
read -p "Press any key to start tag/build  ..."
git tag -s -m "$commit" $tag
read -p "Press any key to start build/build ..."
php build/build.php
