_: {
  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/D762-6C63";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/rpool/swap"; }];

  boot.initrd.luks.devices = {
    crypthome = {
      device = "/dev/rpool/home";
      preLVM = false;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/rpool/root";
      options = [ "subvol=@nix" ];
      fsType = "btrfs";
    };
    "/home" = {
      device = "/dev/mapper/crypthome";
      fsType = "btrfs";
    };
  };
}
