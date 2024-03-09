{lib, ...}:
with lib; {
  swapDevices = [{device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504";}];

  fileSystems = {
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/C9ED-A99E";
      fsType = "vfat";
    };
    "/" = btrfsMount "/dev/rpool/root" "@nix";
    "/home" = btrfsMount "/dev/rpool/home" "@home";
    "/home/michal_atlas/Games" = btrfsMount "/dev/rpool/vault" "@games";
    "/home/michal_atlas/Downloads" = btrfsMount "/dev/rpool/vault" "@tmp";
    "/home/michal_atlas/tmp" = btrfsMount "/dev/rpool/vault" "@tmp";
  };
}
