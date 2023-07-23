#!/bin/bash
VERSION_FILE='joomla-cms/libraries/src/Version.php'
MAJOR_VERSION=$(php -r "define('JOOMLA_PLATFORM','Yes'); require('$VERSION_FILE'); $version = new Version; echo $version->MAJOR_VERSION;")
echo $MAJOR_VERSION
