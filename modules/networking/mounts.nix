{config, ...}: let
  # https://wiki.nixos.org/wiki/Samba#Samba_Client
  automount_opts = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
in {
  fileSystems = {
    "/RouterDisk" = {
      device = "//192.168.0.1/sda1";
      fsType = "cifs";
      options = automount_opts ++ ["vers=1.0" "user=anonymous" "pass=no"];
    };
    "/NX" = {
      device = "https://cloud.michal-atlas.cz/remote.php/dav/files/michal_atlas";
      fsType = "davfs";
      options = automount_opts ++ ["_netdev" "user"];
    };
  };
  services.davfs2.enable = true;
  environment.etc."davfs2/secrets".source = config.age.secrets.webdav.path;
}
