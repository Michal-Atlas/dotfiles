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
  services.nfs = {
    server = {
      enable = true;
      exports = with builtins;
        concatStringsSep "\n"
        (map (dir: "${dir} fd4c:16e4:7d9b::/64(rw,nohide,crossmnt,root_squash,mp)")
          [
            "/"
            "/var"
            "/home/michal_atlas"
            "/home/michal_atlas/Games"
          ]);
    };
  };
  networking.firewall.allowedTCPPorts = [2049];
  fileSystems =
    {
      "/RouterDisk" = {
        device = "//192.168.0.1/sda1";
        fsType = "cifs";
        options =
          automount_opts
          ++ [
            "vers=1.0"
            "user=anonymous"
            "uid=michal_atlas"
            "pass=no"
            "dir_mode=0700"
            "file_mode=0600"
          ];
      };
      "/NX" = {
        device = "https://cloud.michal-atlas.cz/remote.php/dav/files/michal_atlas";
        fsType = "davfs";
        options =
          automount_opts
          ++ [
            "_netdev"
            "uid=michal_atlas"
            "use_locks=0"
          ];
      };
    }
    // (with builtins; (listToAttrs
      (map (name: {
        name = "/net/${name}";
        value = {
          device = "${name}:/";
          fsType = "nfs";
          options = automount_opts;
        };
      }) (attrNames config.atlasnet.wireguard))));
  services.davfs2.enable =
    true;
  age.secrets.nextdav.file = ../../secrets/nextdav;
  environment.etc."davfs2/secrets".source = config.age.secrets.nextdav.path;
}
