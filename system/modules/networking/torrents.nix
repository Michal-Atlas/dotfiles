{ config, ... }: {
  services.transmission = {
    enable = true;
    settings = {
      watch-dir = "${config.users.users.michal_atlas.home}/Downloads";
      watch-dir-enabled = true;
      trash-original-torrent-files = true;
    };
  };
}
