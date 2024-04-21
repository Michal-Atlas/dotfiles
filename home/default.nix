{pkgs, ...}: {
  imports = [
    ../programs
    ../files
    ./services.nix
    ../dconf.nix
    ./registry.nix
    ./mail.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
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
    bix = "nix --store \"/bignix\"";
    lah = "ls -lah";
  };
  fonts.fontconfig.enable = true;
  xsession.numlock.enable = true;
  programs.home-manager.enable = true;

  home.packages =
    [
      pkgs.atlas-emacs
      (pkgs.writeShellScriptBin "srun"
        (let
          nix = "${pkgs.nix}/bin/nix";
          fzf = "${pkgs.fzf}/bin/fzf";
          jq = "${pkgs.jq}/bin/jq";
        in ''
          ${nix} run "nixpkgs#$(nix search --json nixpkgs "$@" | ${jq} 'keys[]' -r | ${fzf} --preview='${nix} search nixpkgs#{}')"
        ''))
    ]
    ++ import ../packages.nix pkgs;

  systemd.user.tmpfiles.rules = [
    "e /home/michal_atlas/Downloads - - - 2d"
    "e /home/michal_atlas/tmp - - - 2d"
  ];
}
