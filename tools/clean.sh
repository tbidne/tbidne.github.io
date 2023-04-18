#!/usr/bin/env bash

set -e

del_exists () {
  if [[ -e $1 ]]; then
    echo "Deleting $1"
    rm -rf $1
  fi
}

# Process args

all=0
static=0
while [ $# -gt 0 ]; do
  if [[ $1 == "--help" || $1 == "-h" ]]; then
    echo -e "clean: Removes generated files / directories.\n"
    echo "Usage: clean [-a|--all]"
    echo "             [-s|--static]"
    echo "             [-h|--help]"
    echo ""
    echo "Available options:"
    echo -e "  -a,--all    \tDeletes node_modules/ and vendor/. Implies --static."
    echo -e "              \tThe next run will require npm install and bundle install.\n"
    echo -e "  -s,--static \tDeletes assets/js/dist. The next run will require"
    echo -e "              \tnpm run build.\n"
    exit 0
  elif [[ $1 == "--all" || $1 == "-a" ]]; then
    all=1
    static=1
  elif [[ $1 == "--static" || $1 == "-s" ]]; then
    static=1
  else
    echo "Unexpected arg: '$1'. Try --help."
    exit 1
  fi
  shift
done

del_exists ".jekyll-metadata"
del_exists "_site"
del_exists ".sass-cache"

if [[ $static = 1 ]]; then
  del_exists "assets/js/dist"
fi

if [[ $all = 1 ]]; then
  del_exists "node_modules"
  del_exists "vendor"
fi