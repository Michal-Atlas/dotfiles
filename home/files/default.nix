_: {
  home.file = {
    ".guile".source = ./guile.scm;
    ".sbclrc".source = ./sbcl.lisp;
    ".face".source = builtins.fetchurl {
      url = "https://git.sr.ht/~michal_atlas/www/blob/0802f55143d49d07dc0ffaefbd197b9322c759d4/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg";
      sha256 = "sha256:05szymcb5745xm8bcj1d8gyiyf1y5m9x6nijyghqz949haqwgjfl";
    };
  };
  xdg.configFile."nixpkgs/config.nix".text = ''
    { allowUnfree = true; }
  '';
}
