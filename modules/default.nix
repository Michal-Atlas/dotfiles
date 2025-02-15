{ lib, ... }:
{
  imports = [
    # keep-sorted start
    ./networking
    ./nix.nix
    ./postgres.nix
    ./registry.nix
    ./user.nix
    # keep-sorted end
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
