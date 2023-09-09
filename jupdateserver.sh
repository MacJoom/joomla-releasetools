#!/bin/bash
#Change xml's 
#www/core/nightlies/next_minor_extension.xml and www/core/nightlies/next_minor_list.xml
#Replace 4.4.0-dev with 4.4.0-alpha3-dev
#Make sure you are in master, create new branch and switch to it
. globals.sh
rm -rf update.joomla.org
#s="4.4.0-$extra$extranum-dev"
s="4.4.0-$oldextra$oldextranum-dev"
r="4.4.0-$extranext$extranumnext-dev"
b="4.4.0-$extra$extranum"
echo "Coming from: $s going to: $r branch: $b"
git clone git@github.com:MacJoom/update.joomla.org.git
cd update.joomla.org
git checkout master
git branch $b
git switch $b
cd ..

file1="update.joomla.org/www/core/nightlies/next_minor_extension.xml"
file2="update.joomla.org/www/core/nightlies/next_minor_list.xml"
sed -i "s/$s/$r/g" $file1
sed -i "s/$s/$r/g" $file2
cd update.joomla.org
git commit -am "$b"
git push --set-upstream origin $b
