<div align="center">

# My Jekyll Website

[![Website](https://img.shields.io/website?up_color=2db74d&down_color=cd2735&label=tbidne.github.io&url=https%3A%2F%2Ftbidne.github.io&labelColor=2f353e)](https://tbidne.github.io)
[![MIT](https://img.shields.io/github/license/tbidne/tbidne.github.io?color=blue&labelColor=2f353e)](https://opensource.org/licenses/MIT)

[![pages-build-deployment](https://github.com/tbidne/tbidne.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/tbidne/tbidne.github.io/actions/workflows/pages/pages-build-deployment)
[![build](https://github.com/tbidne/tbidne.github.io/actions/workflows/build.yaml/badge.svg)](https://github.com/tbidne/tbidne.github.io/actions/workflows/build.yaml)

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
