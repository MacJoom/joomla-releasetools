#!/bin/bash
. globals.sh
cd joomla-cms
export GPG_TTY=$(tty)
read -p "Press any key to start build/build ..."
php build/build.php
