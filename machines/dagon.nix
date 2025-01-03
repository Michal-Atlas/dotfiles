{
  flake,

  ...
}:
with flake.self.lib;
{
  imports = [
    ./laptop.nix
    flake.inputs.nixos-hardware.nixosModules.dell-inspiron-14-5420
  ];
  swapDevices = [ { device = "/dev/sda2"; } ];

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
}
