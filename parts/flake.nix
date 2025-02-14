{
  description = "annt's flake-parts template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts/main";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # pre-commit hooks
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix/master";
      flake = false;
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      imports =
        let
          modDir = ./nix/flake;
        in
        with builtins;
        map (mod: "${modDir}/${mod}") (attrNames (readDir modDir));
    };
}
