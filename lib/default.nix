{
  zfsMounts =
    builtins.mapAttrs
    (_: device: {
      fsType = "zfs";
      inherit device;
    });
  btrfsMount = dev: subvol: {
    device = dev;
    options = [
      "subvol=${subvol}"
      "noatime"
      "compress=zstd"
    ];
    fsType = "btrfs";
  };
}
