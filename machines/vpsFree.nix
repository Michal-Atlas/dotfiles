{
  config,
  lib,
  ...
}:
{
  imports = [
    ../modules/user.nix
    ../modules/networking
    ../modules/nix.nix
  ];
  networking.hostName = "vorpal";
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
    services.emacs.enable = lib.mkForce false;
    programs.emacs.enable = lib.mkForce false;
    dconf.enable = lib.mkForce false;
  };
  services.yggdrasil.settings = {
    Peers = [
      # Czechia
      "tls://[2a03:3b40:fe:ab::1]:993"
      "tls://37.205.14.171:993"
      # Germany
      "tcp://193.107.20.230:7743"
    ];
    MulticastInterfaces = [ ];
  };
  networking.firewall.allowedTCPPorts = [
    993
  ];
}
