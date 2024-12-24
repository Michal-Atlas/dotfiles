_: {
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          keep-sorted.enable = true;
          deadnix.enable = true;
          nixfmt.enable = true;
          toml-sort.enable = true;
          statix.enable = true;
          shellcheck.enable = true;
          shfmt.enable = true;
          yamlfmt.enable = true;
        };
        settings.lisp-format = {
          command = "${pkgs.emacs-nox}/bin/emacs";
          options = [
            "-Q"
            "--script"
            "${pkgs.fetchurl {
              name = "lisp-format";
              # MIT Licensed (also written in the script)
              url = "https://raw.githubusercontent.com/eschulte/lisp-format/refs/heads/master/lisp-format";
              hash = "sha256-hCEhve+phDugxpbiaAXEOK+TsIKZzdh6rvgS6tsqAsg=";
            }}"
            "--"
            "-i"
          ];
          includes = [
            "*.lisp"
            ".el"
          ];
        };
      };
      pre-commit = {
        check.enable = true;
        settings.hooks = {
          nil.enable = true;
          check-yaml.enable = true;
          commitizen.enable = true;
          treefmt.enable = true;
        };
      };
    };
}
