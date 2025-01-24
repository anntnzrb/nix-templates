{
  description = "annt's devenv template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts/main";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # devenv
    devenv = {
      url = "github:cachix/devenv/main";
      inputs = {
        nixpkgs.follows = "nixpkgs";

        # optional
        flake-compat.follows = "";
        nix.follows = "";
        cachix.follows = "";
      };
    };

    devenv-root.url = "file+file:///dev/null";
    devenv-root.flake = false;

    # containers
    nix2container.url = "github:nlewo/nix2container/master";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin/main";

    # pre-commit
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.flake = false;
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = with inputs; [
        devenv.flakeModule
        (pre-commit-hooks + /flake-module.nix)
      ];

      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem =
        { pkgs, config, ... }:
        {
          devenv.shells.default = {
            devenv.root =
              let
                f = builtins.readFile inputs.devenv-root.outPath;
              in
              pkgs.lib.mkIf (f != "") f;

            name = "devenv-shell";

            packages = [
              #pkgs.just
            ];

            languages = {
              nix.enable = true;
            };
          };

          pre-commit.settings.hooks = {
            nixfmt-rfc-style.enable = true;
          };

          checks.default = config.checks.pre-commit;
        };
    };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };
}
