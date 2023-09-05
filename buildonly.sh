#!/bin/bash
. globals.sh
echo "Checkout: $checkout"
echo "Branch: $branch"
echo "Tag: $tag"
echo "Commit: $commit"
echo "Next: $next"
cd joomla-cms
export GPG_TTY=$(tty)
read -p "Press any key to start build/build ..."
php build/build.php
