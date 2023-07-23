# joomla-devtools
Tools for Joomla Development abd Release Management on the command line

Work in progress!

## build.sh
Build a Joomla Release Package, cloning from Joomla Repo

## jcheckout.sh 
Clone a Joomla Dev from Repo, set remote upstream to original joomla-cms
Fetch Upstream, Checkout Dev
copy configuration.php from base dir
run jinstall

## jdelete.sh
Drop all tables from DB with a certain prefix

## jdump.sh
Dump all tables from DB with a certain prefix to prefixedtable_dump.sql

## jrestore.sh
Restore the tables previously dumped to prefixedtable_dump.sql

## jupdateserver.sh 
Clone update.joomla.org from Repo
Checkout master
Create new branch 
replace string in nightlies xml (only minor)
commit and push

