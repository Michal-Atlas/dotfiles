{
  config,
  lib,
  ...
}: {
  options.backups = with lib; {
    home-mount = mkOption {
      type = types.str;
    };
    preservation = mkOption {
      type = types.str;
    };
  };

  config = {
    services.btrbk.instances."btrbk" = {
      settings = {
        volume.${config.backups.home-mount} = {
          subvolume."." = {
            snapshot_dir = ".btrfs";
            snapshot_create = "onchange";
            timestamp_format = "long-iso";
            snapshot_preserve_min = "latest";
            snapshot_preserve = config.backups.preservation;
          };
        };
      };
      onCalendar = "hourly";
    };
  };
}
