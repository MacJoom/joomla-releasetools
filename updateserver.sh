#!/bin/bash
#Change xml's 
#www/core/nightlies/next_minor_extension.xml and www/core/nightlies/next_minor_list.xml
#Example: Replace 4.4.0-dev with 4.4.0-alpha3-dev
#Make sure you are in master, create new branch and switch to it
if [ -z "$1" ]
then
  echo "Please give first parameter true or false if you want a new repository clone of update.joomla.org"
  exit
fi
clone=$1
if ! [ -z "$2" ]
then
    if [ -f "globals$2.sh" ]
    then
        . globals$2.sh
    else
	echo "Error: globals$2.sh does not exist! Exit"
	exit 9
    fi
else
    . globals.sh
fi
repoowner="MacJoom"
repository="https://github.com//$repoowner/update.joomla.org.git"
#git@github.com:MacJoom/update.joomla.org.git
echo "Repository for updateserver.joomla.org: $repository"
if [ -z "$extra" ] #are we on stable
then
    if [ "$extra" = "$oldextra" ] # did the extra change?
    then
      if [ "$patchversion" = "0" ] # are we on zero?
      then
	    s="$oldmajversion.$oldminversion.$oldpatchversion-dev"
	    r="$majversion.$minversion.$nextpatchversion-dev"
      else
	    s="$majversion.$minversion.$patchversion-dev"
	    r="$majversion.$minversion.$nextpatchversion-dev"
      fi
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

echo "Nightlies: Coming from: $s going to: $r branch: $b"
if ($clone)
then
  rm -rf update.joomla.org
  echo "Have you updated the branch on your repository?"
  read -p "Press any key to clone and do the update..."
  git clone git@github.com:$repoowner/update.joomla.org.git
else
  read -p "Press any key to start from existing repository"
fi
cd update.joomla.org
#git checkout 4.4.5-5.1.1
read -p "Press any key to do the update..."
if [ "$patchversion" = "0" ] # are we on zero?
then
    olddot=$oldmajversion.$oldminversion.$((oldpatchversion-1))
    newdot=$majversion.$minversion.$patchversion
else
    olddot=$majversion.$minversion.$((patchversion-1))
    newdot=$majversion.$minversion.$patchversion
fi
echo "Stable: Coming from: $olddot going to: $newdot"
#Replace Title and Url of infourl
files=( "www/core/list.xml" "www/core/sts/list_sts.xml" "www/core/sts/extension_sts.xml" "www/core/j4/default.xml" "www/core/j4/next.xml")
if [ "$patchversion" = "0" ] # are we on zero? then replace version and description
then
    oldtitle="Joomla $oldmajversion.$oldminversion"
    newtitle="Joomla $majversion.$minversion.$patchversion Release"    
else
    oldtitle="Joomla $majversion.$minversion"
    newtitle="Joomla $majversion.$minversion.$patchversion Release"
fi
echo "Replace Title and Url of infourl $oldtitle $newtitle"
for f in "${files[@]}"
do
    echo "$f"
    sed -i -e "s/\(<infourl title=\"$oldtitle\).*\(<\/infourl>\)/<infourl title=\"$newtitle\">$infourl<\/infourl>/g" $f
    if [ "$patchversion" = "0" ] # are we on zero? then replace version and description
    then
	echo "Setting new Major/Minor $oldmajversion.$oldminversion to $majversion.$minversion version in name and description"
	sed -i -e "s/<name>Joomla\! $oldmajversion.$oldminversion<\/name>/<name>Joomla\! $majversion.$minversion<\/name>/g" $f
	sed -i -e "s/<description>Joomla\! $oldmajversion.$oldminversion CMS<\/description>/<description>Joomla! $majversion.$minversion CMS<\/description>/g" $f
    fi
done
#Replace dash pattern e.g. 4-4-1 to 4-4-2
if [ "$patchversion" = "0" ] # are we on zero? then replace version and description
then
    olddash=$oldmajversion-$oldminversion-$((oldpatchversion-1))
    newdash=$majversion-$minversion-$patchversion
else
    olddash=$majversion-$minversion-$((patchversion-1))
    newdash=$majversion-$minversion-$patchversion
fi
echo "Replace dash pattern e.g. $olddash to $newdash"
for f in "${files[@]}"
do
  echo "$f"
  sed -i -e "s/$olddash/$newdash/g" $f
done
#Replace dot pattern e.g. 4-4-1 to 4-4-2
if [ "$patchversion" = "0" ] # are we on zero? then replace version and description
then
    olddot=$oldmajversion.$oldminversion.$((oldpatchversion-1))
    newdot=$majversion.$minversion.$patchversion
else
    olddot=$majversion.$minversion.$((patchversion-1))
    newdot=$majversion.$minversion.$patchversion
fi

echo "Replace dot pattern e.g. $olddot to $newdot"
for f in "${files[@]}"
do
  echo "$f"
  sed -i -e "s/$olddot/$newdot/g" $f
done
#nightlies
files=( "www/core/nightlies/next_major_extension.xml" "www/core/nightlies/next_major_list.xml" "www/core/nightlies/next_minor_extension.xml" "www/core/nightlies/next_minor_list.xml" "www/core/nightlies/next_patch_extension.xml" "www/core/nightlies/next_patch_list.xml" )
echo "nightlies"
for f in "${files[@]}"
do
  echo "$f"
  sed -i -e "s/$s/$r/g" $f
    if [ "$patchversion" = "0" ] # are we on zero? then replace version and description
    then
	sed -i -e "s/<name>Joomla\! $oldmajversion.$oldminversion Nightly Build<\/name>/<name>Joomla! $majversion.$minversion Nightly Build<\/name>/g" $f
    fi
done

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

