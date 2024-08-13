{
  description = "My Jekyll website";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      self,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem =
        { pkgs, ... }:
        let
          # In general, see https://pages.github.com/versions/ for when to
          # upgrade ruby and other gems. We'd __like__ to be on ruby 3.3
          # since that's what gh-pages is on. Alas, that leads to some
          # weird build error with eventmachine. In the log file:
          #
          # vendor/cache/ruby/3.3.0/extensions/x86_64-linux/3.3.0/eventmachine-1.2.7/gem_make.out:
          #
          #     current directory: /home/tommy/Dev/tommy/github/tbidne.github.io/vendor/cache/ruby/3.3.0/gems/eventmachine-1.2.7/ext
          #     make DESTDIR\= sitearchdir\=./.gem.20240814-1186416-ddf0rt sitelibdir\=./.gem.20240814-1186416-ddf0rt
          #     compiling binder.cpp
          #     cc1plus: error: /opt/local/include: Permission denied
          #
          # Here's what the successful log looks like:
          #
          # vendor/cache/ruby/3.2.0/extensions/x86_64-linux/3.2.0/eventmachine-1.2.7/gem_make.out:
          #
          #     current directory: /home/tommy/Dev/tommy/github/tbidne.github.io/vendor/cache/ruby/3.2.0/gems/eventmachine-1.2.7/ext/fastfilereader
          #     make DESTDIR\= sitearchdir\=./.gem.20240814-1172542-bpj9pi sitelibdir\=./.gem.20240814-1172542-bpj9pi
          #     compiling mapper.cpp
          #
          # That is, there's no reference to binder.cpp. But that's weird,
          # because binder.cpp has existed in eventmachine for a long time.
          # Moreover, there are other cpp files that are not showin up in the
          # logs. So not sure what's being compiled, or why binder.cpp is
          # giving us an error in 3.3.
          #
          # Here's a difference. In the successful log file:
          #
          # vendor/cache/ruby/3.2.0/extensions/x86_64-linux/3.2.0/eventmachine-1.2.7/mkmf.log
          #
          # We have a bunch of lines like (rg "checking for"):
          #
          #     have_type: checking for rb_fdset_t in ruby/intern.h... -------------------- yes
          #
          # Whereas in the failing 3.3:
          #
          # vendor/cache/ruby/3.3.0/bundler/gems/extensions/x86_64-linux/3.3.0/eventmachine-42374129ab73/mkmf.log
          #
          # We have more that aren't found e.g.
          #
          #     have_type: checking for rb_fdset_t in ruby/intern.h... -------------------- no
          #
          # So maybe the 3.3 build cannot find a bunch of system libs it needs,
          # so it tried to rebuild them, hence failure? Plausible, but just an
          # idea.
          #
          # For now, stick to 3.2 and hope this is fixed in nixpkgs.
          buildTools = [
            pkgs.nodejs_22
            pkgs.rubyPackages_3_2.jekyll
            pkgs.ruby_3_2
          ];
        in
        {
          devShells.default = pkgs.mkShell { buildInputs = buildTools; };
        };
      systems = [
        "x86_64-darwin"
        "x86_64-linux"
      ];
    };
}
