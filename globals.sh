# Release configuration, sourced by lib.sh. Edit at the start of every release.
# Derived values (tag, commit, next, branch, ...) are computed in lib.sh and printed by every script.

repoowner="joomla"            # owner of the CMS repo to release from; selects ../config.git.<repoowner>
#repoowner="MacJoom"
forkowner="MacJoom"           # your fork, used by upmerge-prepare.sh and updateserver.sh

majversion="6"
minversion="2"
patchversion="1"
extra=""                      # pre-release stage of this release (alpha, beta, rc), empty for stable
extranum=""
extranext=""                  # stage after this one, used for the reset-to-dev version
extranumnext=""
oldextra=""                   # stage of the previous release (updateserver.sh)
oldextranum=""
oldmajversion=""              # previous version, only needed by updateserver.sh for X.Y.0 releases
oldminversion=""
oldpatchversion=""

codename="Mwezi"
reldate="2026-11-24 16:00"    # UTC
revdate="2026-11-24 16:01"    # reset-to-dev date
previoustag="6.2.0"           # for the GitHub release text
infourl="https://www.joomla.org/announcements/release-news/joomla-6-2-1-security-bugfix-release.html"

#checkout="6.2-dev"           # default: $majversion.$minversion-dev
upmergeBranch="5.4-dev"       # default: the previous minor's -dev branch (6.1-dev here)
