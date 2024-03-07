_: {
  imports = [
    ./backups.nix
    ./syncthing.nix
  ];
  services.gvfs.enable = true;
  services.btrfs.autoScrub.enable = true;
}
