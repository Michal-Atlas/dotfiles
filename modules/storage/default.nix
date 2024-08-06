_: {
  imports = [
    ./syncthing.nix
    ./ipfs.nix
  ];
  services.gvfs.enable = true;
}
