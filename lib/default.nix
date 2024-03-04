{
  btrfsMount =
    dev: subvol: {
      device = dev;
      options = [ "subvol=${subvol}" "noatime"
                  "compress=zstd" ];
      fsType = "btrfs";
    };
}
