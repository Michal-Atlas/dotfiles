{ flake, ... }:
with flake.self.lib;
let
  DISKN_UUID = "00061528-79fc-4dce-8e9e-3d78b23cd7a6";
in
{
  swapDevices = [ { device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504"; } ];
  boot.zfs.extraPools = [ "blackpool" ];
  systemd.tmpfiles.rules = [
    "e /DISKN/@cache/cache - - - 60d"
  ];

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
      "/" = btrfsMount "/dev/disk/by-uuid/${DISKN_UUID}" "@nix";
      "/DISKN" = btrfsMount "/dev/disk/by-uuid/${DISKN_UUID}" "/";
    };
  services.btrfs.autoScrub.enable = true;
  atlas.routerDisk.enable = true;
}
