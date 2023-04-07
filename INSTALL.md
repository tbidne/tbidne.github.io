# Initial Setup

1. Enter nix shell

    ```
    nix develop
    ```

1. Build gems

    ```
    bundle install
    ```

    Add `vendor` to `.gitignore` if it is not already there.

1. Build assets

    ```
    npm install
    npm run build
    ```

1. Run

    ```
    ./bin/serve
    ```

    Navigate to http://localhost:4000/ to verify the site is up.

# Jekyll Misc

In general, for a jekyll project there is also the following preliminary step. However this is already been performed and committed for this project, so it is unnecessary (and in fact will likely not work). We leave it here for documentation.

1. Initialize jekyll

    ```
    # force because we are building in the current directory
    jekyll new ./ --force

    bundle config set --local path 'vendor/cache'
    ```