{ pkgs, ... }: {
  services.btrbk.instances."btrbk" = {
    settings = {
      volume."/home" = {
        subvolume."." = {
          snapshot_dir = ".btrfs";
          snapshot_create = "onchange";
          timestamp_format = "long-iso";
          snapshot_preserve_min = "1h";
          snapshot_preserve = "25h 31d 4w 12m";
        };
      };
    };
    onCalendar = "*:0/12";
  };
}
