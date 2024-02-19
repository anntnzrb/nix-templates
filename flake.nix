{
  description = "annt's Templates for Nix";

  inputs = {
    nix-templates.url = "github:nixos/templates/master";
    rust-annt.url = "github:anntnzrb/rusted/main";
    haskell-annt.url = "github:anntnzrb/kell/main";
  };

  outputs = { self, ... }@inputs: {
    templates = rec {
      default = trivial;

      trivial = {
        path = "${inputs.nix-templates.outPath}/empty";
        description = "The trivial flake";
      };

      devenv = {
        path = ./templates/devenv;
        description = "annt's devenv";
      };

      rust = {
        path = inputs.rust-annt.outPath;
        description = "annt's Rust";
      };

      haskell = {
        path = inputs.haskell-annt.outPath;
        description = "annt's Haskell";
      };
    };
  };
}
