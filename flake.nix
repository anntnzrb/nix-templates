{
  description = "annt's templates for Nix";

  inputs = {
    nix-templates.url = "github:nixos/templates/master";

    srid-rust.url = "github:srid/rust-nix-template/master";
    srid-haskell.url = "github:srid/haskell-template/master";
    annt-www.url = "github:anntnzrb/wwwsoy/main";
  };

  outputs = { self, ... }@inputs: {
    templates = {
      default = self.templates.trivial;

      trivial = {
        path = "${inputs.nix-templates.outPath}/empty";
        description = "The trivial flake";
      };

      devenv = {
        path = ./templates/devenv;
        description = "annt's devenv";
      };

      rust = {
        path = inputs.srid-rust.outPath;
        description = "srid's Rust";
      };

      haskell = {
        path = inputs.srid-haskell.outPath;
        description = "srid's Haskell";
      };

      www = {
        path = inputs.annt-www.outPath;
        description = "annt's www";
      };
    };
  };
}
