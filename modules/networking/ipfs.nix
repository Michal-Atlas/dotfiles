{ lib, ... }:
{
  networking.firewall.allowedUDPPorts = [ 4001 ];
  services.kubo = {
    enable = lib.mkDefault false;
    autoMount = true;
    settings = {
      Experimental.FilestoreEnabled = true;
      Peering.Peers = [
        {
          ID = "12D3KooWRrLK1fnBwC5iWLERwhQpbMroBxJcnkPVksfN3Tvq95Su";
          Addrs = [ "/dnsaddr/vorpal/udp/4001/quic-v1" ];
        }
        {
          ID = "12D3KooWKAJGUfGYmwVwVTXWZvcfX9GXTTxMj9Wo4MJXp16jJeuM";
          Addrs = [ "/dnsaddr/leviathan/udp/4001/quic-v1" ];
        }
        {
          ID = "12D3KooWAReeVpS5j3heFbgPHKXKLfepYywawmV5cHBQXRQb3x8y";
          Addrs = [ "/dnsaddr/hydra/udp/4001/quic-v1" ];
        }
      ];
      Addresses = {
        API = [
          "/ip6/::1/tcp/5001"
          "/ip4/127.0.0.1/tcp/5001"
        ];
        Gateway = [
          "/ip6/::1/tcp/8080"
          "/ip4/127.0.0.1/tcp/8080"
        ];
      };
      Routing = {
        AcceleratedDHTClient = false;
        Type = "auto";
      };
      Reprovider = {
        Interval = lib.mkDefault "0h";
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
