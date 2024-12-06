{ config, lib, ... }:
let
  # https://wiki.nixos.org/wiki/Samba#Samba_Client
  automount_opts = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
in
{
  options = {
    atlas.routerDisk.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.atlas.routerDisk.enable {
    fileSystems = {
      "/RouterDisk" = {
        device = "//192.168.0.1/sda1";
        fsType = "cifs";
        options = automount_opts ++ [
          "vers=1.0"
          "user=anonymous"
          "uid=michal_atlas"
          "pass=no"
          "dir_mode=0700"
          "file_mode=0600"
        ];
      };
    };
  };
}
