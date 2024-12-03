_:
let
  multiCastPort = 123;
in
{
  services.yggdrasil = {
    enable = true;
    group = "wheel";
    openMulticastPort = true;
    persistentKeys = true;

    settings = {
      Peers = [
        # Czechia
        "tls://[2a03:3b40:fe:ab::1]:993"
        "tls://37.205.14.171:993"
        # Germany
        "tcp://193.107.20.230:7743"
      ];
      MulticastInterfaces = [
        {
          Regex = ".*";
          Beacon = true;
          Listen = true;
          Port = multiCastPort;
          Priority = 0;
          Password = "";
        }
      ];
      IfName = "ygg0";
    };
  };
  networking.firewall.allowedTCPPorts = [ multiCastPort ];
}
