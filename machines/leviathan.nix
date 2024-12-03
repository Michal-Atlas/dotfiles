{ flake, ... }:
with flake.self.lib;
{
  imports = [
    ./laptop.nix
    flake.inputs.nixos-hardware.nixosModules.dell-latitude-5520
  ];
  swapDevices = [ { device = "/dev/nvme0n1p2"; } ];

  fileSystems =
    zfsMounts { "/" = "rpool/root"; }
    // {
      "/home/michal_atlas" = {
        fsType = "zfs";
        device = "rpool/home";
        depends = [ "/" ];
      };
    }
    // {
      "/var" = {
        fsType = "zfs";
        device = "rpool/var";
        depends = [ "/" ];
      };
    }
    // {
      "/nix" = {
        fsType = "zfs";
        device = "rpool/store";
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

}
