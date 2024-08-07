{
  description = "annt's template for devenv";

  nixConfig = {
    extra-trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
    extra-substituters = [ "https://devenv.cachix.org" ];
  };

  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";

    # src tree fmt
    treefmt-nix = {
      url = "github:numtide/treefmt-nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # devenv
    devenv.url = "github:cachix/devenv/main";
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    nix2container = {
      url = "github:nlewo/nix2container/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin/main";
  };

  outputs = inputs@{ flake-parts, devenv-root, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = with inputs; [
        devenv.flakeModule
        treefmt-nix.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, pkgs, ... }: {
        devenv.shells.default = {
          name = "annt-devenv-template";

          devenv.root =
            let
              devenvRootFileContent = builtins.readFile devenv-root.outPath;
            in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

          languages = {
            nix.enable = true;
          };

          devcontainer = {
            enable = true;
            settings = {
              image = "ghcr.io/cachix/devenv:latest";
              updateContentCommand = "direnv reload";
              customizations.vscode.extensions = [
                "mkhl.direnv"
                "jnoortheen.nix-ide"
              ];
            };
          };

          packages = with pkgs; [
            just
            config.treefmt.build.wrapper
          ];

          enterShell = ''
            cat <<EOF

              🐚✒️ Get started: 'just <recipe>'
              `just`

            EOF
          '';
        };

        treefmt.config = {
          projectRootFile = "flake.nix";
          programs = {
            nixpkgs-fmt.enable = true;
            prettier.enable = true;
          };
        };
      };
    };
}
