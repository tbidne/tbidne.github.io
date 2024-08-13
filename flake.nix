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
          buildTools = [
            pkgs.nodejs_22
            pkgs.rubyPackages_3_1.jekyll
            pkgs.ruby_3_1
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
