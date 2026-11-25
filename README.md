# joomla-releasetools

Bash helpers for doing a Joomla! CMS release from the Linux command line: clone, apply security fixes, bump, sign and tag, build packages, update the update server, push, and reset to dev.

All the Joomla 4.4 releases and the 6.2 releases so far were made with these scripts.

> **Work in progress.** The scripts are interactive. They pause before every important step, so **press Enter to continue or Ctrl-C to abort**. They stop at the first failing command (`set -euo pipefail`) and print every changing command (`+ git …`) before they run it.

---

## Directory layout and prerequisites

Every script works in the *web root*, the parent directory of this repository. They change into it themselves, so you can start them from anywhere (set `RELEASE_WORKDIR` to use another directory):

```
web/
├── joomla-releasetools/        ← this repo
├── globals.sh            → symlink (created by .symlinks.sh; lib.sh is not linked)
├── build.sh              → symlink …
├── config.git.joomla           ← .git/config template for joomla/joomla-cms (NOT in this repo)
├── config.git.MacJoom          ← .git/config template for your fork (NOT in this repo)
├── joomla-cms/                 ← working clone (deleted and re-created by several scripts!)
├── joomla-test/                ← optional second clone (clonetojoomla-test.sh)
├── joomla-github-text/         ← checkout of the GitHub release-text generator (github-text.sh)
└── update.joomla.org/          ← clone of your fork of update.joomla.org (updateserver.sh)
```

Requirements:

- bash 4 or later (`globals.sh` uses `${var^}`), git, PHP, composer and npm. In other words, a working Joomla development setup.
- A GPG signing key set up for git. Tags are signed with `git tag -s`, and `GPG_TTY` is exported for pinentry.
- SSH access to `github.com` for the security repository and update.joomla.org.
- **`config.git.<repoowner>`**: a complete `.git/config` copied over the fresh clone's config. It must contain:
  - `[user]` with name, email and `signingkey`
  - `[remote "origin"]` with a URL that includes a push token
  - optionally `[commit] gpgsign = true`, because the bump commits are made without `-S`

  These files contain secrets. Keep them out of every repository.

Set up the symlinks once, and again after scripts are added or removed:

```bash
cd web
bash joomla-releasetools/.symlinks.sh   # links every *.sh into web/, removes links to deleted scripts
```

Real files in `web/` with the same name as a script are left alone and reported as skipped.

---

## Configuration: `globals.sh`

`globals.sh` only holds the release settings. `lib.sh` (sourced by every script) loads it, derives the values below and prints them, so check them before you continue. Edit `globals.sh` at the start of each release.

To use another config file, set `GLOBALS`, for example `GLOBALS=globals-4.4.13.sh ./pushtag.sh`.

| Variable | Meaning | Example |
|---|---|---|
| `repoowner` | GitHub owner of the CMS repo. Also selects `config.git.<repoowner>` | `joomla` (live) / `MacJoom` (fork) |
| `forkowner` | Your fork, used by `upmerge-prepare.sh` and `updateserver.sh` | `MacJoom` |
| `majversion` / `minversion` / `patchversion` | Version being released | `6` / `2` / `1` |
| `oldmajversion` / `oldminversion` / `oldpatchversion` | Previous version. Used only by `updateserver.sh` when `patchversion=0` | |
| `extra` / `extranum` | Pre-release stage of **this** release. Empty for stable | `RC` / `2` |
| `oldextra` / `oldextranum` | Stage of the **previous** release. Used by `updateserver.sh` | `RC` / `1` |
| `extranext` / `extranumnext` | Stage after this one. Used for `$next` | `RC` / `3` |
| `codename` | Release codename passed to `bump.php` | `Mwezi` (6.2), `Pamoja` (4.4) |
| `reldate` | Release date and time in **UTC** | `2026-11-24 16:00` |
| `revdate` | Reset-to-dev date, usually one minute later | `2026-11-24 16:01` |
| `previoustag` | Previous tag, used for the GitHub release text | `6.2.0` |
| `infourl` | Release announcement URL. Plain URL; the old escaped `https:\/\/` form also still works | |
| `upmergeBranch` | Optional. Branch merged up into `checkout` | `5.4-dev` |
| `checkout` | Optional. Branch to release from | `6.2-dev` |

Derived values:

| Variable | Stable (`extra=""`) | Pre-release |
|---|---|---|
| `repository` | `https://github.com/<repoowner>/joomla-cms.git` | |
| `checkout` (default) | `6.2-dev` | `6.2-dev` |
| `tag` | `6.2.1` | `6.2.1-RC2` |
| `commit` | `Joomla! 6.2.1 Stable` | `Joomla! 6.2.1 RC 2` |
| `next` (reset-to-dev target, `-dev` is appended) | `6.2.2` | `6.2.1-RC3` |
| `branch` (legacy release-branch flow only) | `6.2.1-stable` | `6.2.1-RC` |
| `upmergeBranch` (default) | the previous minor, `6.1-dev`; `X.0` uses `(X-1).4-dev` | |

`globals-4.4.13.sh`, `globals4.4.3.sh`, `globals4.4.3rc1.sh` and `globals5-1-0.sh` are snapshots from earlier releases. Load one with `GLOBALS=…`, or with the second argument of `updateserver.sh`.

---

## Release workflow (current, 6.x)

The release is made **directly on the `X.Y-dev` branch**. No release branch is created.

```
 edit globals.sh
      │
      ▼
 build.sh  ──(stop before bump if security fixes are needed)──► secmerge.sh ──► buildfrombump.sh
      │                                                                              │
      ▼◄─────────────────────────────────────────────────────────────────────────────┘
 check build/tmp/packages, upload to the private test server
      │   (rebuild with buildonly.sh if needed)
      ▼
 updateserver.sh true        → prepare the update.joomla.org PR
 github-text.sh              → generate the GitHub release notes
      │
      ▼   at release time
 pushtag.sh                  → push the signed tag, then create the GitHub release and upload packages
 reverttodevandpush.sh       → bump to <next>-dev, commit, push the dev branch
```

1. **Edit `globals.sh`** and check the printed values.
2. **`build.sh`**: fresh clone, bump, commit, signed tag, build. Nothing is pushed.
3. **Security release?** Abort `build.sh` (Ctrl-C) at *"Press any key to start build/bump"*. Merge the security PRs with **`secmerge.sh <pr>…`** or by hand, then run **`buildfrombump.sh`**.
4. Check `joomla-cms/build/tmp/packages` and upload the packages to the private server for testing. Use **`buildonly.sh`** to rebuild.
5. **`updateserver.sh true`**: prepare the update-server changes. Then review, commit and open the PR by hand.
6. **`github-text.sh`**: writes `joomla-github-text/github_release.txt`.
7. At release time, **`pushtag.sh`**: push the release tag, then create the GitHub release from it.
8. **`reverttodevandpush.sh`**: reset-to-dev bump, commit, push. This also pushes the release commit.

---

## Script reference

✱ = runs `rm -rf` on a working directory. ⬆ = pushes to GitHub.

### Setup and cloning

| Script | What it does |
|---|---|
| `.symlinks.sh` | Creates a symlink in the parent directory for each `*.sh` in this repo (except `lib.sh`) and removes links to deleted scripts. Real files are not replaced. |
| `lib.sh` | Shared helpers sourced by every script: strict mode, config loading and derived values, pauses, clone/bump/tag/build steps. Not run directly. |
| `cloneandcheckoutonly.sh` ✱ | Deletes `joomla-cms`, clones `$repository`, checks out `$checkout`, installs `config.git.$repoowner`. |
| `clonetojoomla-test.sh` ✱ | Same as above, into `joomla-test` (a scratch clone for testing). |

### Building

| Script | What it does |
|---|---|
| `build.sh` ✱ | **Main entry point.** Deletes `joomla-cms`, clones, checks out `$checkout`, installs the git config, then `bump.php -v $tag -c $codename -d $reldate`, `git commit -am "$commit"`, `git tag -s $tag`, `build.php`. No push. |
| `buildfrombump.sh` | Resumes in the existing `joomla-cms` from the bump step (bump, `git add .`, commit, tag, build). Use it after merging security fixes. |
| `buildfromtag.sh` | Resumes from the tag step (tag, build), for when the bump commit already exists. |
| `buildonly.sh` | Only runs `php build/build.php` in `joomla-cms`. |
| `buildfromcheckout.sh` ⬆ | *Legacy release-branch flow.* In the existing clone, creates `$branch` from `$checkout`, **pushes it**, then bump, commit, tag, build. |
| `buildfrombranch.sh` ✱ | *Legacy release-branch flow.* Fresh clone of the already pushed `$branch`, then bump, commit, tag, build. The tag must not have been pushed yet. |

### Security fixes

| Script | What it does |
|---|---|
| `secmerge.sh <pr>…` | In the existing `joomla-cms`, adds the `security` remote (`joomla/cms-security`, push disabled) if it is missing. Then for each PR number: fetches `pull/<pr>/head` into branch `security-<pr>`, squash merges it and commits *"Prepare Joomla! X.Y.Z"*. Continue with `buildfrombump.sh`. |

### Publishing

| Script | What it does |
|---|---|
| `pushtag.sh` ⬆ | Shows the status, branch and matching tags, then pushes **only** `$tag` (`git push origin refs/tags/$tag`). |
| `reverttodevandpush.sh` ⬆ | `bump.php -v $next-dev -d $revdate`, `git add .`, `git commit -s -m "Reset to dev"`, `git push`. |
| `finalpush.sh` ⬆ | Shows the status and branch, then a plain `git push`. Use it if the reset-to-dev push was skipped. |
| `github-text.sh` | Runs `php github-text.php --tag --previous-tag --release-page` in `joomla-github-text/`, writing `github_release.txt`. |

### Update server: `updateserver.sh <clone> [globals-suffix]`

Prepares the changes to the update-server XML in a clone of **your fork** of `update.joomla.org` (`git@github.com:<forkowner>/update.joomla.org.git`).

- `<clone>`: `true` deletes the directory and clones it again, `false` reuses the existing `update.joomla.org/`.
- `[globals-suffix]`: loads `globals<suffix>.sh` instead of `globals.sh`, for example `-4.4.13` for `globals-4.4.13.sh`.

What it changes:
- `www/core/list.xml`, `sts/list_sts.xml`, `sts/extension_sts.xml`, `j4/default.xml`, `j4/next.xml`: the `<infourl>` title and URL, the `X-Y-Z` dash pattern and the `X.Y.Z` dot pattern. For `.0` releases it also changes `<name>` and `<description>`, and it needs `oldmajversion`/`oldminversion`/`oldpatchversion`.
- `www/core/nightlies/next_{major,minor,patch}_{extension,list}.xml`: the `…-dev` version of the nightly builds.

It does **not** create a branch, commit or push. Review `git diff` first, then use the branch/commit/push commands it prints at the end.

### Upmerge: `upmerge-prepare.sh` ✱

Prepares an upmerge PR from `$upmergeBranch` into `$checkout` on the fork:
deletes and clones `joomla-cms`, installs `config.git.<forkowner>`, adds `upstream`, renames `origin` to `<forkowner>`, lists the previous upmerge commits and the ahead/behind counts, creates `X.Y-upmerge-YYYY-MM-DD` from `<forkowner>/$checkout` and merges `upstream/$upmergeBranch`. It stops so you can resolve conflicts. Pushing and the PR are done by hand.

---

## Windows / network share note

When the repo is on an SMB share and git runs on Windows, `git status` shows every script as modified (mode `100755 → 100644`). Do not commit those changes. Run this once:

```bash
git config core.filemode false
```

---

Comments and PRs welcome.
