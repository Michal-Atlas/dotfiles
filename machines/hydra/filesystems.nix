{ flake, ... }:
with flake.self.lib;
let
  DISKA_UUID = "880d14ef-f964-4956-84a7-e457db80a5ad";
  DISKB_UUID = "65920de2-b793-4480-bda7-4e04c4d9eb59";
  DISKN_UUID = "00061528-79fc-4dce-8e9e-3d78b23cd7a6";
in
{
  swapDevices = [ { device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504"; } ];

  fileSystems =

    {
      "/home/michal_atlas" = btrfsMount "/dev/disk/by-uuid/${DISKA_UUID}" "@home";
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/C9ED-A99E";
        fsType = "vfat";
      };
      "/" = btrfsMount "/dev/disk/by-uuid/${DISKN_UUID}" "@nix";
      "/DISKA" = btrfsMount "/dev/disk/by-uuid/${DISKA_UUID}" "/";
      "/DISKB" = btrfsMount "/dev/disk/by-uuid/${DISKB_UUID}" "/";
      "/DISKN" = btrfsMount "/dev/disk/by-uuid/${DISKN_UUID}" "/";
    };
  services.beesd.filesystems = {
    # "DISKB" = {
    #   spec = "UUID=${DISKB_UUID}";
    # } // common;
    # "DISKA" = {
    #   spec = "UUID=${DISKA_UUID}";
    # } // common;
  };
  services.btrbk.instances."home".settings = {
    timestamp_format = "long-iso";
    snapshot_preserve_min = "1w";
    snapshot_preserve = "7d 4w 12m *y";

    target_preserve_min = "1w";
    target_preserve = "7d 4w 12m *y";

    volume."/DISKA" = {
      subvolume = "@home";
      snapshot_dir = "snaps";
      snapshot_create = "onchange";
      target = "/DISKB/snap_backups";
    };
  };
  atlas.routerDisk.enable = true;
  # services.nfs = {
  #   server = {
  #     enable = true;
  #     exports =
  #       with builtins;
  #       concatStringsSep "\n" (
  #         map (dir: "${dir} 192.168.0.0/24(rw,nohide,crossmnt,root_squash,mp)") [
  #           "/DISKA"
  #           "/DISKB"
  #         ]
  #       );
  #   };
  # };
}
