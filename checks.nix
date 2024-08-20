_: {
  perSystem = { pkgs, ... }: {
    pre-commit = {
      check.enable = true;
      settings.hooks = {
        nixfmt.enable = true;
        shellcheck.enable = true;
        statix.enable = true;
        shfmt.enable = true;
        nil.enable = true;
        deadnix.enable = true;
        commitizen.enable = true;

        elisp-autofmt = {
          enable = true;
          name = "Elisp Autofmt";
          entry = "${
              (pkgs.writeShellScriptBin "autofmt.sh" ''
                ${
                  (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages
                  (epkgs: with epkgs; [ elisp-autofmt ])
                }/bin/emacs "$1" --batch --eval "(require 'elisp-autofmt)" -f elisp-autofmt-buffer -f save-buffer --kill'')
            }/bin/autofmt.sh";
          files = "\\.(el)$";
        };
      };
    };
  };
}
