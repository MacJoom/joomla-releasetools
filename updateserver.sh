#!/bin/bash
#Change xml's 
#www/core/nightlies/next_minor_extension.xml and www/core/nightlies/next_minor_list.xml
#Example: Replace 4.4.0-dev with 4.4.0-alpha3-dev
#Make sure you are in master, create new branch and switch to it
. globals.sh
rm -rf update.joomla.org
if [ -z "$extra" ] #are we on stable
then
    if [ "$extra" = "$oldextra" ] # did the extra change?
    then
	s="$majversion.$minversion.$patchversion-dev"
	r="$majversion.$minversion.$nextpatchversion-dev"
    else
	s="$majversion.$minversion.$patchversion-$oldextra$oldextranum-dev" 
	r="$majversion.$minversion.$nextpatchversion-dev"
    fi	    
    b="$majversion.$minversion.$patchversion-stable"
else
    if [ "$extra" = "$oldextra" ] # did the extra change?
    then
	s="$majversion.$minversion.$patchversion-$extra$extranum-dev"
	r="$majversion.$minversion.$patchversion-$extranext$extranumnext-dev"
    else
	s="$majversion.$minversion.$patchversion-$oldextra$oldextranum-dev" 
	r="$majversion.$minversion.$patchversion-$extranext$extranumnext-dev"
    fi	    
    b="$majversion.$minversion.$patchversion-$extra$extranum"
fi
echo "Have you updated the branch on your repository?"
echo "Coming from: $s going to: $r branch: $b"
read -p "Press any key to clone and do the update..."
git clone git@github.com:$repoowner/update.joomla.org.git
cd update.joomla.org
git checkout master
#git checkout 5.0.1-stable
#git branch $b
#git switch $b
#cd ..
#file1="update.joomla.org/www/core/nightlies/next_minor_extension.xml"
#file2="update.joomla.org/www/core/nightlies/next_minor_list.xml"
#sed -i "s/$s/$r/g" $file1
#sed -i "s/$s/$r/g" $file2
#cd update.joomla.org
#git commit -am "$b"
#git push --set-upstream origin $b

