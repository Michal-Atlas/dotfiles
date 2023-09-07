_: {
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/C9ED-A99E";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504"; }];

  services.btrfs.autoScrub.enable = true;
  fileSystems = {
    "/" = {
      device = "/dev/spool/root";
      options = [ "subvol=@nix" ];
      fsType = "btrfs";
    };
    "/home" = {
      device = "/dev/rpool/home";
      options = [ "subvol=@home" ];
      fsType = "btrfs";
    };
    "/home/michal_atlas/Games" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@games" ];
      fsType = "btrfs";
    };
    "/home/michal_atlas/Downloads" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@tmp" ];
      fsType = "btrfs";
    };
    "/home/michal_atlas/tmp" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@tmp" ];
      fsType = "btrfs";
    };
    "/var/lib/ipfs" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@ipfs" ];
      fsType = "btrfs";
    };
  };
}
