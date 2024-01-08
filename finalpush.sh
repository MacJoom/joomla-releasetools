#!/bin/bash
. globals.sh
export GPG_TTY=$(tty)
cd joomla-cms
git status
git branch -v
read -p "Press any key to do the final push..."
git push

