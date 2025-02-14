{
  inputs,
  ...
}:
{
  imports = [ (inputs.git-hooks-nix + /flake-module.nix) ];

  perSystem =
    { pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        flake-checker.enable = true;

        nixfmt-rfc-style = {
          enable = true;
          settings.width = 80;
        };

        deadnix = {
          enable = true;
          settings = {
            edit = true;
            noUnderscore = true;
          };
        };

        statix =
          let
            cfg = (pkgs.formats.toml { }).generate "statix.toml" {
              disabled = disabled-lints;
            };
            disabled-lints = [ "repeated_keys" ];
          in
          {
            enable = true;
            package = pkgs.writeShellApplication {
              name = "statix";
              runtimeInputs = [ pkgs.statix ];
              text = ''
                shift
                exec statix check --config ${cfg} "$@"
              '';
            };
          };
      };
    };
}
