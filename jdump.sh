#!/bin/bash
dbuser=c2u3
db=c2j3
dbpw=cdxXfugCSAJ9#
prefix=i03ob
mysql $db -u $dbuser -p$dbpw -N -e 'show tables like "'$prefix'\_%"' | xargs mysqldump $db -u $dbuser -p$dbpw > prefixedtable_dump.sql
