#!/bin/bash
. globals.sh
repoowner="MacJoom"
read -p "Press any key to start..."
export GPG_TTY=$(tty)
rm -rf joomla-cms
git clone $repository
cd joomla-cms
cp -rf ../config.git.$repoowner .git/config
git remote add upstream https://github.com/joomla/joomla-cms.git
git remote rename origin $repoowner
git checkout $checkout
git fetch --all --prune
git pull
git log --oneline --merges --grep="$upmergeBranch"
read -p "Next: rev-list without commit number"
git rev-list --count upstream/$upmergeBranch..upstream/$checkout
read -p "Next: git log "
git log --oneline upstream/$checkout..upstream/$upmergeBranch
read -p "Next: summary with rev-list"
git rev-list --left-right --count upstream/$checkout...upstream/$upmergeBranch
read -p "Next: checkout new branch"
git checkout -b "$majversion.$minversion-upmerge-$(date +%F)" MacJoom/$checkout
read -p "Next: merge with $upmergeBranch"
git merge upstream/$upmergeBranch
read -p "Check Conflicts now"
