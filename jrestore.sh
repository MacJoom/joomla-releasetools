#!/bin/bash
dbuser=c2u3
db=c2j3
dbpw=cdxXfugCSAJ9#
mysql $db -u $dbuser -p$dbpw <prefixedtable_dump.sql
