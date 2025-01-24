{
  description = "annt's templates for Nix";

  outputs =
    { self }:
    {
      templates = {
        default = self.templates.devenv;

        devenv = {
          path = ./devenv;
          description = "devenv template";
        };
      };
    };
}
