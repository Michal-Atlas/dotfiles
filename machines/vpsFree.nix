{ lib, ... }:
{
  imports = [
    ../modules/user.nix
    ../modules/networking
    ../modules/nix.nix
  ];
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "24.11";
  home-manager.users."michal_atlas" = {
    home.packages = lib.mkForce [ ];
    programs = {
      firefox.enable = lib.mkForce false;
      gnome-shell.enable = lib.mkForce false;
      thunderbird.enable = lib.mkForce false;
    };
  };
}
