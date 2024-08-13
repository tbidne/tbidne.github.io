#!/usr/bin/env bash

set -e

# Process args

clean=0
static=0
while [ $# -gt 0 ]; do
  case "$1" in
    "-h" | "--help")
      echo -e "build: Builds the website.\n"
      echo "Usage: build [-c|--clean]"
      echo "             [-s|--static]"
      echo "             [-h|--help]"
      echo ""
      echo "Available options:"
      echo -e "  -c,--clean  \tIf enabled, runs ./bin/clean --all. Implies --static."
      echo -e "              \tRequired libs will be reinstalled.\n"
      echo -e "  -s,--static \tBuilds static assets.\n"
      exit 0
      ;;
    "-c" | "--clean")
      clean=1
      static=1
      ;;
    "-s" | "--static")
      static=1
      ;;
    *)
      echo "Unexpected arg: '$1'. Try --help."
      exit 1
      ;;
  esac
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
