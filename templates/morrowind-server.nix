{ pkgs, ... }:
{
  systemd.services."tes3mp-server" = {
    wants = [ "network.target" ];
    after = [ "syslog.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    environment = {
      XDG_CONFIG_HOME = "/rpool/tes3mp/config";
      XDG_DATA_HOME = "/rpool/tes3mp/data";
    };
    script = "${pkgs.openmw-tes3mp}/bin/tes3mp-server";
  };

  networking.firewall.allowedTCPPorts = [ 25565 ];
}
