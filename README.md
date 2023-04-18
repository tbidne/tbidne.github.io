<div align="center">

# My Jekyll Website

[![Website](https://img.shields.io/website?up_color=2db74d&down_color=cd2735&label=tbidne.github.io&url=https%3A%2F%2Ftbidne.github.io&labelColor=2f353e)](https://tbidne.github.io)
[![MIT](https://img.shields.io/github/license/tbidne/tbidne.github.io?color=blue&labelColor=2f353e)](https://opensource.org/licenses/MIT)

[![pages-build-deployment](https://github.com/tbidne/tbidne.github.io/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/tbidne/tbidne.github.io/actions/workflows/pages/pages-build-deployment)
[![build](https://github.com/tbidne/tbidne.github.io/actions/workflows/build.yaml/badge.svg)](https://github.com/tbidne/tbidne.github.io/actions/workflows/build.yaml)
[![style](https://github.com/tbidne/tbidne.github.io/actions/workflows/style.yaml/badge.svg)](https://github.com/tbidne/tbidne.github.io/actions/workflows/style.yaml)

</div>

---

# Introduction

This is my jekyll website, based on the terrific template at https://github.com/cotes2020/jekyll-theme-chirpy.

# Building

Development uses [nix flakes](https://nixos.wiki/wiki/Flakes). Nix is used to provide dependencies, so if nix is not available, the following will have to be provided manually:

- `bundle`
- `jekyll`
- `nodejs`
- `ruby`

1. Enter nix shell

   ```
   nix develop
   ```

1. Install bundle/node dependencies and build

   ```
   ./tools/build.sh -c
   ```

1. Run

   ```
   ./tools/serve.sh
   ```

   Navigate to http://localhost:4000/ to verify the site is up.

# Development

After the first build most changes are watched automatically with `./tools/serve.sh`, so there is no need to manually run build commands.

If, however, any changes are made to `_javascript/*` then the static assets will have to be rebuilt:

```
./tools/build.sh -s
```

Developer tools/scripts can be found in the [tools](/tools) directory.

# Release

The [release.sh](/tools/release.sh) script will:

1. Rebase the `release` branch on the current `main`.
1. Perform a clean build.
1. Commit the changes and push to github.

This will trigger the github action for performing a new deployment.
