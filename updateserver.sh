#!/bin/bash
# Prepare the update-server XML changes in a clone of $forkowner/update.joomla.org:
#   www/core/{list,sts/*,j4/*}.xml   infourl title/URL, X-Y-Z and X.Y.Z versions (name/description on .0)
#   www/core/nightlies/*.xml          the -dev version of the nightly builds
# Nothing is committed or pushed: review with git diff, then branch, commit and open the PR by hand.
#
# Usage: updateserver.sh <true|false> [globals-suffix]
#   true  = delete and re-clone update.joomla.org, false = reuse the existing clone
#   globals-suffix loads globals<suffix>.sh, e.g. -4.4.13 for globals-4.4.13.sh
case "${1:-}" in
    true | false) clone=$1 ;;
    *)
        echo "Usage: $0 <true|false> [globals-suffix]   (true = fresh clone of update.joomla.org)" >&2
        exit 1
        ;;
esac
[[ -n ${2:-} ]] && GLOBALS="globals$2.sh"
. "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/lib.sh"

UPDATE_DIR="update.joomla.org"
update_repo="git@github.com:$forkowner/update.joomla.org.git"

# Escape a literal string for the pattern / the replacement side of sed s/…/…/
sed_re() { printf '%s' "$1" | sed 's/[][\/.^$*]/\\&/g'; }
sed_rep() { printf '%s' "$1" | sed 's/[\/&]/\\&/g'; }

# replace <from> <to> <file>...: replace a literal string in files
replace() {
    local from to f
    from=$(sed_re "$1")
    to=$(sed_rep "$2")
    shift 2
    for f in "$@"; do
        echo "  $f"
        sed -i -e "s/$from/$to/g" "$f"
    done
}

dotzero=false
if [[ $patchversion == 0 ]]; then
    dotzero=true
    [[ -n $oldmajversion && -n $oldminversion && -n $oldpatchversion ]] \
        || die "a .0 release needs oldmajversion, oldminversion and oldpatchversion in $GLOBALS"
fi

# Nightlies: from -dev version $s to $r
if [[ -z $extra ]]; then
    if [[ $extra != "$oldextra" ]]; then
        s="$version-$oldextra$oldextranum-dev"
    elif $dotzero; then
        s="$oldmajversion.$oldminversion.$oldpatchversion-dev"
    else
        s="$version-dev"
    fi
    r="$majversion.$minversion.$nextpatchversion-dev"
    b="$version-stable"
else
    if [[ $extra == "$oldextra" ]]; then
        s="$version-$extra$extranum-dev"
    else
        s="$version-$oldextra$oldextranum-dev"
    fi
    r="$version-$extranext$extranumnext-dev"
    b="$version-$extra$extranum"
fi

# Stable lists: previous release → this release, in dot (X.Y.Z) and dash (X-Y-Z) form
if $dotzero; then
    oldnums=("$oldmajversion" "$oldminversion" "$((oldpatchversion - 1))")
    oldtitle="Joomla $oldmajversion.$oldminversion"
else
    oldnums=("$majversion" "$minversion" "$((patchversion - 1))")
    oldtitle="Joomla $majversion.$minversion"
fi
olddot=$(IFS=.; echo "${oldnums[*]}")
olddash=$(IFS=-; echo "${oldnums[*]}")
newdot=$version
newdash="$majversion-$minversion-$patchversion"
newtitle="Joomla $version Release"

echo "Update repo:  $update_repo"
echo "Nightlies:    $s -> $r (suggested branch: $b)"
echo "Stable:       $olddot -> $newdot, $olddash -> $newdash"
echo "Infourl:      \"$oldtitle…\" -> \"$newtitle\" $infourl"

if [[ $clone == true ]]; then
    echo "Have you updated the branch on your fork?"
    pause "This DELETES $WORK_DIR/$UPDATE_DIR and clones $update_repo."
    rm -rf -- "$UPDATE_DIR"
    run git clone "$update_repo" "$UPDATE_DIR"
else
    pause "Use the existing $WORK_DIR/$UPDATE_DIR."
fi
enter_dir "$UPDATE_DIR"
pause "Next: change the XML files."

files=(
    www/core/list.xml
    www/core/sts/list_sts.xml
    www/core/sts/extension_sts.xml
    www/core/j4/default.xml
    www/core/j4/next.xml
)
echo "Infourl title and URL"
for f in "${files[@]}"; do
    echo "  $f"
    sed -i -e "s/<infourl title=\"$(sed_re "$oldtitle").*<\/infourl>/<infourl title=\"$(sed_rep "$newtitle")\">$(sed_rep "$infourl")<\/infourl>/g" "$f"
done
if $dotzero; then
    echo "Name and description $oldmajversion.$oldminversion -> $majversion.$minversion"
    replace "<name>Joomla! $oldmajversion.$oldminversion</name>" "<name>Joomla! $majversion.$minversion</name>" "${files[@]}"
    replace "<description>Joomla! $oldmajversion.$oldminversion CMS</description>" "<description>Joomla! $majversion.$minversion CMS</description>" "${files[@]}"
fi
echo "Dash pattern $olddash -> $newdash"
replace "$olddash" "$newdash" "${files[@]}"
echo "Dot pattern $olddot -> $newdot"
replace "$olddot" "$newdot" "${files[@]}"

nightlies=(
    www/core/nightlies/next_major_extension.xml
    www/core/nightlies/next_major_list.xml
    www/core/nightlies/next_minor_extension.xml
    www/core/nightlies/next_minor_list.xml
    www/core/nightlies/next_patch_extension.xml
    www/core/nightlies/next_patch_list.xml
)
echo "Nightlies $s -> $r"
replace "$s" "$r" "${nightlies[@]}"
if $dotzero; then
    replace "<name>Joomla! $oldmajversion.$oldminversion Nightly Build</name>" "<name>Joomla! $majversion.$minversion Nightly Build</name>" "${nightlies[@]}"
fi

git status --short
echo "Review with 'git diff' in $PWD, then e.g.:"
echo "  git switch -c $b && git commit -am '$b' && git push --set-upstream origin $b"
