{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./helix.nix
  ];
  programs = {
    fzf.enable = true;
    alacritty = {
      enable = true;
      settings = {
        window = {
          decorations_theme_variant = "Dark";
          dynamic_padding = true;
        };
        cursor.style = {
          shape = "Beam";
          blinking = "On";
        };
        mouse.hide_when_typing = true;
      };
    };
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
