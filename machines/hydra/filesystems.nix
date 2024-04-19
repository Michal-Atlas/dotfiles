{lib, ...}:
with lib; {
  swapDevices = [{device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504";}];

  fileSystems =
    zfsMounts {
      "/home/michal_atlas/Games" = "rpool/games";
      "/home/michal_atlas" = "rpool/home/michal_atlas";
      "/var" = "rpool/var";
      "/bignix" = "rpool/bignix";
    }
    // {
      "/RouterDisk" = {
        device = "//192.168.0.1/sda1";
        fsType = "cifs";
        options = let
          # https://wiki.nixos.org/wiki/Samba#Samba_Client
          automount_opts = [
            "x-systemd.automount"
            "noauto"
            "x-systemd.idle-timeout=60"
            "x-systemd.device-timeout=5s"
            "x-systemd.mount-timeout=5s"
          ];
        in
          automount_opts ++ ["vers=1.0" "user=anonymous" "pass=no"];
      };
      "/boot/efi" = {
        device = "/dev/disk/by-uuid/C9ED-A99E";
        fsType = "vfat";
      };
      "/" = btrfsMount "/dev/rpool/root" "@nix";
    };
}
