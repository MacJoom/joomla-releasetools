# joomla-releasetools
Tools for Joomla! Release Management on the linux command line - uses bash

Work in progress! Works for Minor releases only at the moment

I have done some Joomla 4.4.0 Alpha releases with the following tools

Any comments and/or PR's welcome!

## Workflow:
1) Setup up globals.sh
2) Do build.sh (pushes the newly created branch!)
3) If you have to do security updates you have to stop before bump and do a buildfrombump.sh 
4) Check your build (build/tmp/packages), upload to private server
5) use buildonly.sh to redo the build
6) updateserver.sh to prepare a PR for the nightlies
7) at the time of release:
8) pushtag.sh (Pushes the tag so you can prepare the release on github, upload the files)
9) reverttodevandpush.sh (Does the revert to dev bump and the final push)


## globals.sh
- Set's up all constants used by the scripts

## build.sh
Build a Joomla Release Package, cloning from Joomla Repo
- deletes joomla-cms
- clones from github.com//joomla/joomla-cms.git
- cd's into joomla-cms
- checks out current dev
- creates release branch
- switches to release branch
- copies the .git/config for the key
- pushes branch
- builds the release bump
- commits the bump
- creates the new release tag
- builds the release
No further push yet

## buildfrombump.sh (can only to be done before the bump and commits are done)
Restarts with the bump, after applying security updates
- builds the release bump
- commits the bump
- creates the new release tag
- builds the release
No push

## buildonly.sh
Just builds the Joomla Release Package
- cd's into joomla-cms
- calls php build/build.php
No push

## buildfrombranch.sh
Rebuild a Joomla Release Package, cloning from Joomla Repo from the already existing release branch - can only be done if not pushed yet
- deletes joomla-cms
- clones from github.com//joomla/joomla-cms.git
- cd's into joomla-cms
- checks out branch
- - builds the release bump
- commits the bump
- creates the new release tag
- builds the release
No further push yet

## pushtag.sh
- cd's into joomla-cms
- shows status und branch
- shows tags
- pushes the tag

## updateserver.sh 
- Clone update.joomla.org from Repo
- Checkout master
- Create new branch 
- replace string in nightlies xml (only minor)
- commit and push  

## reverttodevandpush.sh
- cd's into joomla-cms
- builds the revert to dev bump
- stages files (git add .)
- commits "Revert to dev"
- does the final push
