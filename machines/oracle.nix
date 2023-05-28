{ ... }:
{
  imports = [ ../templates/morrowind-server.nix ];
  system.stateVersion = "23.05";
  networking.hostName = "oracle";
  nixpkgs.hostPlatform = "x86_64-linux";
  users.users."root".initialPassword = "foobar270";
  boot.growPartition = true;
  services = {
    openssh.enable = true;
    # resolved = {
    #   enable = true;
    #   llmnr = "false";
    # }; };
  };
  networking = {
    firewall.enable = false;
    # networkmanager.enable = true;       
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
