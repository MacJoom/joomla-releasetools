#!/bin/bash
dbuser=c2u3
db=c2j3
dbpw=cdxXfugCSAJ9#
prefix=i03ob
cp drop_table.tmpl drop_table_$prefix.sql
sed -i "s/#DB#/$db/g" drop_table_$prefix.sql
sed -i "s/#PREFIX#/$prefix/g" drop_table_$prefix.sql
mysql $db -u $dbuser -p$dbpw <drop_table_$prefix.sql
