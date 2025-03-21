{
  pkgs,
  ...
}:
{
  imports = [
    # keep-sorted start
    ./files
    ./programs
    ./vim.nix
    # keep-sorted end
  ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home = {
    username = "michal_atlas";
    homeDirectory = "/home/michal_atlas";
  };

  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "22.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];

  home.shellAliases = {
    e = "$EDITOR";
    g = "git";
    cat = "bat";
    lah = "ls -lah";
    nix = "nix -L";
  };
  fonts.fontconfig.enable = true;
  xsession.numlock.enable = true;
  programs = {
    home-manager.enable = true;
    lf = {
      enable = true;
      settings = {
        # keep-sorted start
        drawboxes = true;
        hidden = true;
        icons = true;
        incfilter = true;
        incsearch = true;
        mouse = true;
        relativenumber = true;
        roundbox = true;
        scrolloff = 5;
        sixel = true;
        watch = true;
        # keep-sorted end
      };
      previewer.source = "${pkgs.pistol}/bin/pistol";
    };
    pistol.enable = true;
    zsh = {
      profileExtra = ''
        source /etc/profile
      '';
      initExtra = ''
        setopt completealiases
      '';
    };
    htop = {
      enable = true;
      settings = {
        highlight_base_name = 1;
        hide_userland_threads = 1;
        show_program_path = 0;
      };
    };
  };

  systemd.user.tmpfiles.rules = [
    "d /home/michal_atlas/Downloads - - - 5d"
    "d /home/michal_atlas/tmp - - - 5d"
  ];
}
