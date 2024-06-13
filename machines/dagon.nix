{lib, ...}:
with lib; {
  imports = [./laptop.nix];
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
  networking = {
    hostName = "dagon";
    hostId = "253520d6";
  };

  age.secrets = {
    yggdrasil.file = ../secrets/yggdrasil/dagon.json;
    wireguard.file = ../secrets/wireguard/dagon;
  };
}
