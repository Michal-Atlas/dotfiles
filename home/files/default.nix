_:
{
  home.file =
    {
      ".guile".source = ./guile.scm;
      ".sbclrc".source = ./sbcl.lisp;
      ".inputrc".source = ./inputrc;
      ".gtkrc-2.0".source = ./gtk2.ini;
      ".config/gtk-3.0/settings.ini".source = ./gtk3.ini;
      ".face".source = builtins.fetchurl {
        url = "https://michal_atlas.srht.site/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg";
        sha256 = "sha256:05szymcb5745xm8bcj1d8gyiyf1y5m9x6nijyghqz949haqwgjfl";
      };
      ".local/share/nyxt/bookmarks.lisp".source = ./nyxt/bookmarks.lisp;
      ".config/nyxt/config.lisp".source = ./nyxt/init.lisp;
    };
}
