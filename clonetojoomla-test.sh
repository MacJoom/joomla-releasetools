#!/bin/bash
# Fresh scratch clone of $checkout into joomla-test.
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

require_git_config "$repoowner"
clone_fresh joomla-test "$checkout"
install_git_config "$repoowner"
