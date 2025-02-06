rec {
  zfsMounts = builtins.mapAttrs (
    _: device: {
      fsType = "zfs";
      inherit device;
    }
  );
  btrfsMount = dev: subvol: {
    device = dev;
    options = [
      "subvol=${subvol}"
      "noatime"
      "compress=zstd"
    ];
    fsType = "btrfs";
  };
  nginxDefaults = {
    enableACME = true;
    forceSSL = true;
    http2 = true;
    http3 = true;
  };
  automount_opts = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
}
