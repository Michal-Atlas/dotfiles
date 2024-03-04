{ pkgs, ... }:
{
  programs = {
    git = import ./git.nix;
    ssh = import ./ssh.nix;
    fzf.enable = true;
    dircolors.enable = true;
    keychain.enable = true;
    navi.enable = true;
    direnv = {
      nix-direnv.enable = true;
      enable = true;
    };
    autojump.enable = true;
    zsh = import ./zsh.nix;
    starship.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep batwatch ];
    };
    nix-index.enable = true;
  };
}
