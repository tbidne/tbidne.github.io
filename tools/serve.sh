#!/usr/bin/env bash

check=0
while [ $# -gt 0 ]; do
  case "$1" in
    "-h" | "--help")
      echo -e "fmt.sh: Runs formatter.\n"
      echo "Usage: fmt.sh [-c|--check]"
      echo "              [-h|--help]"
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
  set +e

  timeout -- 5 bundle exec jekyll serve -H 0.0.0.0 -P 4000
  ec=$?

  # Server should timeout i.e. return exit code 124
  if [[ ec -ne 124 ]]; then
    echo "server returned failure: $ec"
    exit 1
  fi
else
  bundle exec jekyll serve -H 0.0.0.0 -P 4000
fi