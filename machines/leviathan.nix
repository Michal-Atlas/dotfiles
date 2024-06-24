{
  lib,
  nixos-hardware,
  ...
}:
with lib; {
  imports = [
    ./laptop.nix
    nixos-hardware.nixosModules.dell-latitude-5520
  ];
  swapDevices = [{device = "/dev/nvme0n1p2";}];

  fileSystems =
    zfsMounts {
      "/" = "rpool/nix";
    }
    // {
      "/home/michal_atlas" = {
        fsType = "zfs";
        device = "rpool/home/michal_atlas";
        depends = [ "/" ];
      };
      "/etc" = {
        fsType = "zfs";
        device = "rpool/nix/etc";
        depends = [ "/" ];
      };
      "/var" = {
        fsType = "zfs";
        device = "rpool/nix/var";
        depends = [ "/" ];
      };
    }
    // {
      "/boot/efi" = {
        device = "/dev/nvme0n1p1";
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
