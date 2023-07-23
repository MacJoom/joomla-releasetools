#!/bin/bash
export GPG_TTY=$(tty)
rm -rf joomla-cms
git clone https://github.com//MacJoom/joomla-cms.git
cd joomla-cms
git checkout 4.4-dev
git branch 4.4.0-alpha1
git switch 4.4.0-alpha1
php build/bump.php -v 4.4.0-alpha1 -c Pamoja -d "2023-10-17 16:01"
git commit -am 'Joomla! 4.4.0 Alpha 1'
git tag -s -m "Joomla! 4.4.0 Alpha 1" 4.4.0-alpha1
php build/build.php
