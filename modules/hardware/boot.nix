{ config, lib, ... }:
{
  config = lib.mkIf config.hardware.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
}
