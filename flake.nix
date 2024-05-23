{
  description = "annt's templates for Nix";

  inputs = {
    nix-templates.url = "github:nixos/templates/master";
    annt-rust.url = "github:anntnzrb/rusted/main";
    annt-haskell.url = "github:anntnzrb/kell/main";
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
        path = inputs.annt-rust.outPath;
        description = "annt's Rust";
      };

      haskell = {
        path = inputs.annt-haskell.outPath;
        description = "annt's Haskell";
      };
    };

    defaultTemplate = self.templates.trivial;
  };
}
