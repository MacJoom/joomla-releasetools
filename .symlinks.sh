#/bin/bash
#Build Symlinks to all .sh Files to the parent directory
#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

echo $SCRIPT_DIR
cd $SCRIPT_DIR
for script in *.sh
do
    rm -f ../$script
    ln -s $SCRIPT_DIR/$script ../$script
    echo Symlinks created: $script
done
cd ..

