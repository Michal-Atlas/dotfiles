{lib, ...}:
with lib; {
  imports = [./laptop.nix];
  swapDevices = [{device = "/dev/nvme0n1p2";}];

  fileSystems =
    zfsMounts {
      "/" = "rpool/nix";
      "/home/michal_atlas" = "rpool/home/michal_atlas";
      "/etc" = "rpool/nix/etc";
      "/var" = "rpool/nix/var";
    }
    // {
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/B08C-A8BE";
        fsType = "vfat";
      };
    };


  networking = {
    hostName = "leviathan";
	hostId = "80fd5bf2";
  };

  age.secrets = {
    yggdrasil.file = ../secrets/yggdrasil/leviathan.json;
    wireguard.file = ../secrets/wireguard/leviathan;
  };
}
