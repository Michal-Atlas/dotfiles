{ ... }:
{
  imports = [
    # keep-sorted start
    ./dconf.nix
    ./emacs.nix
    ./firefox.nix
    ./gnome.nix
    ./hyprland.nix
    ./mail.nix
    ./packages
    ./vim.nix
    # keep-sorted end
  ];
  programs.alacritty = {
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
}
