#!/usr/bin/env bash

set -e

# Process args

clean=0
static=0
while [ $# -gt 0 ]; do
  if [[ $1 == "--help" || $1 == "-h" ]]; then
    echo -e "build: Builds the website.\n"
    echo "Usage: build [-c|--clean]"
    echo "             [-s|--static]"
    echo "             [-h|--help]"
    echo ""
    echo "Available options:"
    echo -e "  -c,--clean  \tIf enabled, runs ./bin/clean --all. Implies --static."
    echo -e "              \tRequired libs will be reinstalled.\n"
    echo -e "  -s,--static  \tBuilds static assets.\n"
    exit 0
  elif [[ $1 == "--clean" || $1 == "-c" ]]; then
    clean=1
    static=1
  elif [[ $1 == "--static" || $1 == "-s" ]]; then
    static=1
  else
    echo "Unexpected arg: '$1'. Try --help."
    exit 1
  fi
  shift
done

if [[ 1 -eq $clean ]]; then
  echo "*** Cleaning everything ***"
  ./tools/clean.sh --all

  echo "*** Installing gems ***"
  bundle install --gemfile=Gemfile

  echo "*** Installing node libraries ***"
  npm install
fi

if [[ 1 -eq $static ]]; then
  echo "*** Cleaning static assets ***"
  ./tools/clean.sh --static

  echo "*** Building static assets ***"
  npm run build
fi

echo "*** Building site ***"
bundle exec jekyll build

echo "*** Finished ***"