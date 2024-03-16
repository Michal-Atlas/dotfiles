{lib, ...}:
with lib; {
  swapDevices = [{device = "/dev/sda2";}];

  fileSystems =
    zfsMounts {
      "/" = "rpool/root";
      "/home/michal_atlas" = "rpool/home/michal_atlas";
      "/etc" = "rpool/etc";
      "/var" = "rpool/var";
    }
    // {
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/D762-6C63";
        fsType = "vfat";
      };
    };
}
