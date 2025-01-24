{
  description = "annt's gleam template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts/main";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # pre-commit
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.flake = false;
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ (inputs.pre-commit-hooks + /flake-module.nix) ];

      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem =
        { pkgs, config, ... }:
        {
          devShells.default = pkgs.mkShellNoCC {
            nativeBuildInputs = with pkgs; [
              erlang_27
              erlang-ls
              rebar3
              gleam
            ];
          };

          pre-commit.settings.hooks = {
            nixfmt-rfc-style.enable = true;
            gleam-fmt = {
              enable = true;
              name = "gleam-fmt";
              description = "Run `gleam format` on all files in the project";
              files = "\.gleam$";
              entry = "${pkgs.gleam}/bin/gleam format";
            };
          };

          checks.default = config.checks.pre-commit;
        };
    };
}
