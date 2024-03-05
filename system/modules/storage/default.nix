_: {
  imports = [
    ./backups.nix
    ./ipfs.nix
    ./syncthing.nix
  ];
  services.gvfs.enable = true;
  services.btrfs.autoScrub.enable = true;
}
