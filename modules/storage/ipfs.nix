{ lib, config, ... }:
{
  services.kubo = {
    enable = true;
    localDiscovery = true;
    autoMount = true;
    settings = {
      Addresses = {
        API = [ "/ip4/127.0.0.1/tcp/5001" ];
        AppendAnnounce = [
          "/ip6/${builtins.getAttr config.networking.hostName config.atlasnet.yggdrasil}/tcp/4001"
        ];
      };
      Routing.Type = lib.mkDefault "autoclient";
      AutoNAT.ServiceMode = "disabled";
      Reprovider = {
        Strategy = lib.mkDefault "pinned";
        Interval = lib.mkDefault 0;
      };
      Swarm = {
        RelayService.Enabled = false;
        ConnMgr = {
          GracePeriod = "1m0s";
          LowWater = lib.mkDefault 20;
          HighWater = lib.mkDefault 40;
        };
        ResourceMgr.MaxMemory = "1GB";
        Import.CidVersion = 1;
        Transports.Network = {
          TCP = false;
          Websocket = false;
          WebTransport = false;
          WebRTCDirect = false;
        };
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      4001
      9096
    ];
    allowedUDPPorts = [ 4001 ];
  };
}
