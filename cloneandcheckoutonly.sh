#!/bin/bash
# Fresh clone of $checkout into joomla-cms with the git config installed. No bump, no build.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

require_git_config "$repoowner"
clone_fresh "$CMS_DIR" "$checkout"
install_git_config "$repoowner"
