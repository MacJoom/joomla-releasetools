#!/bin/bash
# Only rebuild the packages in the existing clone.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

enter_dir "$CMS_DIR"
build_packages
