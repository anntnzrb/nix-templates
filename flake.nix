{
  description = "annt's templates for Nix";

  inputs = {
    annt-dev.url = "github:anntnzrb/dev/main";
    annt-www.url = "github:anntnzrb/wwwsoy/main";

    srid-rust.url = "github:srid/rust-nix-template/master";
    srid-haskell.url = "github:srid/haskell-template/master";
  };

  outputs = inputs: {
    templates = {
      default = inputs.self.templates.dev;

      dev = {
        path = inputs.annt-dev.outPath;
        description = "annt's dev";
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
