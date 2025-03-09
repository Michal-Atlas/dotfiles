{ flake, ... }:
with flake.self.lib;
{
  swapDevices = [ { device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504"; } ];
  boot.zfs.extraPools = [ "blackpool" ];
  fileSystems =

    {
      "/home/michal_atlas" = {
        device = "liverpool/home";
        fsType = "zfs";
      };
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/C9ED-A99E";
        fsType = "vfat";
      };
      "/" = {
        device = "mindpool/nix";
        fsType = "zfs";
      };
    };
  atlas.routerDisk.enable = true;
}
