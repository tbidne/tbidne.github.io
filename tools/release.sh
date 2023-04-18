#!/usr/bin/env bash

# want a better error message if following git check fails
set +e

git diff-index --quiet HEAD --
if [[ 0 -ne $? ]]; then
  echo "*** Error: git directory is dirty! ***"
  exit 1
fi

# recreate release on main
git checkout main

# delete branch release if exists
git branch | grep ^[[:space:]]*release$
if [[ 0 -eq $? ]]; then
  echo "*** Deleting release branch ***"
  git branch -D release
fi

# turn errors back on
set -e

git checkout -b release

# build
./tools/build.sh --clean

# rename for github-pages
mv _site docs

# commit and push
echo "*** Committing ***"
git add docs
git commit -m "Build site"

echo "*** Pushing to github ***"
git push -u -f origin release

# return to main
git checkout main

echo "*** Finished ***"