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
        "tls://vorpal.ip4:993"
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
