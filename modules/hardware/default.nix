{
  config,
  lib,
  ...
}:
{
  imports = [
    ./graphics.nix
    ./virtualization.nix
    ./interfacing.nix
    ./boot.nix
    ./fonts.nix
    ./sound.nix
  ];
  options = {
    hardware.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.hardware.enable {
    services = {
      pcscd.enable = true;
    };
    boot.kernel.sysctl."net.core.wmem_max" = 2500000;
    hardware = {
      xpadneo.enable = true;
      xone.enable = true;
      bluetooth = {
        enable = true;
        settings.General.Experimental = true;
      };
    };
  };
}
