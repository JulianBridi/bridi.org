#!/bin/zsh
# Push the site to bridi.org (origin) and to the mirror at https://julianbridi.github.io
# (same files without CNAME, force-pushed as a single commit).
set -e
cd "$(dirname "$0")"
git push origin main
tmp=$(mktemp -d)
git archive HEAD | tar -x -C "$tmp"
rm -f "$tmp/CNAME" "$tmp/publish.sh" "$tmp/README.md"
cd "$tmp"
git init -q -b main
git add -A
git commit -q -m "Mirror of bridi.org at $(git -C "$OLDPWD" rev-parse --short HEAD)"
git push -q -f https://github.com/JulianBridi/julianbridi.github.io.git main
rm -rf "$tmp"
