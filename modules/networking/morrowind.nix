{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.morrowind-server;
in
{
  options.services.morrowind-server.enable = mkOption {
    type = types.bool;
    default = false;
    description = mdDoc ''
      Enables a Morrowind server and opens its default port
    '';
  };
  config = mkIf cfg.enable {
    systemd.services."tes3mp-server" = {
      wants = [ "network.target" ];
      after = [
        "syslog.target"
        "network-online.target"
      ];
      wantedBy = [ "multi-user.target" ];
      environment = {
        XDG_CONFIG_HOME = "/var/lib/tes3mp/config";
        XDG_DATA_HOME = "/var/lib/tes3mp/data";
      };
      script = "${pkgs.openmw-tes3mp}/bin/tes3mp-server";
    };

    networking.firewall.allowedTCPPorts = [ 25565 ];
  };
}
