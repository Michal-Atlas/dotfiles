{ lib, ... }:
with lib;
{
  swapDevices =
    [{ device = "/dev/rpool/swap"; }];

  boot.initrd.luks.devices = {
    crypthome = {
      device = "/dev/rpool/home";
      preLVM = false;
    };
  };

  fileSystems = {
    "/boot/efi" =
      {
        device = "/dev/disk/by-uuid/D762-6C63";
        fsType = "vfat";
      };
    "/" = btrfsMount "/dev/rpool/root" "@nix";
    "/home/michal_atlas" = {
      device = "/dev/mapper/crypthome";
      options = [ "noatime" ];
      fsType = "btrfs";
    };
  };
}
