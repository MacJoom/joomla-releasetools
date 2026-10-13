#!/bin/bash
. globals.sh
read -p "Press any key to start..."
export GPG_TTY=$(tty)
cd joomla-github-text
echo "php github-text.php --release-page=$infourl > github_release.txt"
php github-text.php --tag=$tag --previous-tag=$previoustag --release-page=$infourl > github_release.txt
cd ..
