{lib, ...}:
with lib; {
  swapDevices = [{device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504";}];

  fileSystems =
    zfsMounts {
      "/home/michal_atlas/Games" = "rpool/games";
      "/home/michal_atlas" = "rpool/home/michal_atlas";
      "/var" = "rpool/var";
    }
    // {
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/C9ED-A99E";
        fsType = "vfat";
      };
      "/" = btrfsMount "/dev/rpool/root" "@nix";
    };
}
