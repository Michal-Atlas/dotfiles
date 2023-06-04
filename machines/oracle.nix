_:
{
  system.stateVersion = "23.05";
  networking.hostName = "oracle";
  nixpkgs.hostPlatform = "x86_64-linux";
  users.mutableUsers = false;
  users.users."michal_atlas" = { group = "users"; extraGroups = [ "wheel" ]; password = "foobar270"; isNormalUser = true; };
  boot.growPartition = true;
  services = {
    openssh.enable = true;
    resolved = {
      enable = true;
      #   llmnr = "false";
    };
  };
  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.grub.devices = [ "/dev/disk/by-label/ESP" ];
}
