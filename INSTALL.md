1. Enter nix shell

    ```
    nix develop
    ```

2. Initialize jekyll

    ```
    # force because we are building in the current directory
    jekyll new ./ --force

    bundle config set --local path 'vendor/cache'
    ```

3. Update Gemfile

    Add the line to the `Gemfile` generated in step 2:

    ```
    gem "webrick"
    ```

4. Build

    ```
    bundle install --gemfile=Gemfile
    ```

    Add `vendor` to `.gitignore` if it is not already there.

5. Run

    ```
    bundle exec jekyll serve
    ```

    Navigate to http://localhost:4000/ to verify the site is up.