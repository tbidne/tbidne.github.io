#!/usr/bin/env bash

set +e

timeout -- 5 bundle exec jekyll serve -H 0.0.0.0 -P 4000
ec=$?

# Server should timeout i.e. return exit code 124
if [[ ec -ne 124 ]]; then
  echo "server returned failure: $ec"
  exit 1
fi