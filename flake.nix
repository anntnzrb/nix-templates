{
  description = "annt's templates for Nix";

  outputs =
    { self }:
    {
      templates =
        let
          mkTemplate = path: description: { inherit path description; };
        in
        {
          parts = mkTemplate ./parts "flake-parts template";
          devenv = mkTemplate ./devenv "devenv template";
          gleam = mkTemplate ./gleam "gleam template";

          default = self.templates.parts;
        };
    };
}
