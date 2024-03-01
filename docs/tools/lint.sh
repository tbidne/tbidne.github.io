#!/usr/bin/env bash

check=0
while [ $# -gt 0 ]; do
  case "$1" in
    "-h" | "--help")
      echo -e "lint.sh: Runs linter.\n"
      echo "Usage: lint.sh [-c|--check]"
      echo "               [-h|--help]"
      exit 0
      ;;
    "-c" | "--check")
      check=1
      ;;
    *)
      echo "Unexpected arg: '$1'. Try --help."
      exit 1
      ;;
  esac
  shift
done

if [[ 1 == $check ]]; then
  npx stylelint _sass/**/*.scss
else
  npx stylelint _sass/**/*.scss --fix
fi