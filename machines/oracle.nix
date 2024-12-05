{ lib, ... }:
{
  imports = [
    ../modules/user.nix
    ../modules/nix.nix
    ../modules/boot.nix
    ../modules/networking
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableAllFirmware = true;
  system.stateVersion = "24.11";
  disko.devices.disk."disk" = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "500M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/efi";
          };
        };
        swap = {
          size = "2G";
          content.type = "swap";
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
