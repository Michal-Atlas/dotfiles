{
  pkgs,
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
      protonmail-bridge = {
        enable = true;
        path = with pkgs; [ gnome-keyring ];
      };
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
    services.nginx = {
      enable = true;
      virtualHosts."127.0.0.1" = {
        listen = [
          {
            port = 8091;
            addr = "127.0.0.1";
          }
        ];
        locations = {
          "/".proxyPass = "http://127.0.0.1:3000";
          "/api".proxyPass = "http://127.0.0.1:8090";
        };
      };
    };
  };
}
