{ lib, ... }:
{
  imports = [
    ./hardware
    ./networking
    ./nix.nix
    ./steam.nix
    ./storage
    ./user.nix
    ./cachix.nix
    ./postgres.nix
    ./registry.nix
  ];
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = lib.mkDefault "22.11";
  time.timeZone = "Europe/Prague";

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld.enable = true;
    nix-index-database.comma.enable = true;
  };
  programs = {
    java = {
      enable = true;
      binfmt = true;
    };
  };
}
