#!/bin/bash
#to be executeded with -i so it will be in joomla-cms.. (bash -i ../jcheckout.sh)
cd ..
bash jdelete.sh
bash jrestore.sh
rm -rf joomla-cms
git clone git@github.com:MacJoom/joomla-cms.git
cd joomla-cms
git remote add upstream https://github.com/joomla/joomla-cms.git
git fetch upstream
git checkout --track upstream/4.3-dev
cp ../configuration.php .
jinstall
exit
