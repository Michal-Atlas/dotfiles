{ pkgs, ... }:
{
  imports = [
    # keep-sorted start
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./zsh.nix
    # keep-sorted end
  ];
  programs = {
    fzf.enable = true;
    ripgrep.enable = true;
    dircolors.enable = true;
    keychain.enable = true;
    navi.enable = true;
    direnv = {
      nix-direnv.enable = true;
      enable = true;
    };
    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
    starship.enable = true;
    bat = {
      enable = true;
      config.style = "header-filename,header-filesize,grid";
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    gpg.enable = true;
  };
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };
}
