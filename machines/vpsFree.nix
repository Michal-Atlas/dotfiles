_: {
  imports = [
    ../modules/user.nix
    ../modules/networking
  ];
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "24.11";
}
