{
  btrfsMount =
    dev: subvol: {
      device = dev;
      options = [ "subvol=${subvol}" "noatime" ];
      fsType = "btrfs";
    };
}
