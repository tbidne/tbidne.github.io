<div align="center">

# My Jekyll Website

[![release](https://img.shields.io/badge/release-0.1-orange)](http://tbidne.github.io)
[![MIT](https://img.shields.io/github/license/tbidne/tbidne.github.io?color=blue)](https://opensource.org/licenses/MIT)

[![pages-build-deployment](https://github.com/tbidne/tbidne.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/tbidne/tbidne.github.io/actions/workflows/pages/pages-build-deployment)
[![build](http://img.shields.io/github/actions/workflow/status/tbidne/tbidne.github.io/build.yaml?branch=main&label=build&logoColor=white&labelColor=2f353c)](https://github.com/tbidne/tbidne.github.io/actions/workflows/build.yaml)
[![style](http://img.shields.io/github/actions/workflow/status/tbidne/tbidne.github.io/style.yaml?branch=main&label=style&logoColor=white&labelColor=2f353c)](https://github.com/tbidne/tbidne.github.io/actions/workflows/style.yaml)

</div>

---

# Introduction

This is my jekyll website, based on the terrific template at https://github.com/cotes2020/jekyll-theme-chirpy.

# Build

1. Enter nix shell

   ```
   nix develop
   ```

1. Build gems

   ```
   bundle install
   ```

1. Build static assets

   ```
   npm install
   npm run build
   ```

1. Run

   ```
   ./bin/serve
   ```

   Navigate to http://localhost:4000/ to verify the site is up.
