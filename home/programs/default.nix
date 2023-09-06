{ pkgs, ... }:
{
  programs = {
    git = import ./git.nix;

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
    exa = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
  };
}
