{ lib, ... }:
{
  services.kubo = {
    enable = lib.mkDefault true;
    autoMount = true;
    settings = {
      Addresses.API = [
        "/ip6/::1/tcp/5001"
        "/ip4/127.0.0.1/tcp/5001"
      ];
      Routing = {
        AcceleratedDHTClient = false;
        Type = "auto";
      };
      Reprovider = {
        Interval = "0h";
        Strategy = "all";
      };
      Swarm.ConnMgr = {
        LowWater = 32;
        HighWater = 96;
      };
      Discovery.MDNS.Enabled = true;
    };
  };
}
