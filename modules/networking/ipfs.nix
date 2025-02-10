{ lib, ... }:
{
  networking.firewall.allowedUDPPorts = [ 4001 ];
  services.kubo = {
    enable = true;
    settings = {
      Import.CidVersion = 1;
      Experimental.FilestoreEnabled = true;
      Peering.Peers = [
        {
          ID = "12D3KooWRrLK1fnBwC5iWLERwhQpbMroBxJcnkPVksfN3Tvq95Su";
          # Vorpal
          Addrs = [
            "/ip4/37.205.15.189/udp/4001/quic-v1"
            "/ip6/2a03:3b40:fe:833::1/udp/4001/quic-v1"
            "/ip6/201:df2c:b49a:7f3d:d54d:5d26:18c9:fc54/udp/4001/quic-v1"
          ];
        }
        {
          ID = "12D3KooWKAJGUfGYmwVwVTXWZvcfX9GXTTxMj9Wo4MJXp16jJeuM";
          # Leviathan
          Addrs = [ "/ip6/200:299c:6b1a:c8ac:bc4d:d2be:cbd:6014/udp/4001/quic-v1" ];
        }
        {
          ID = "12D3KooWAReeVpS5j3heFbgPHKXKLfepYywawmV5cHBQXRQb3x8y";
          # Hydra
          Addrs = [ "/ip6/201:876c:b6b:3561:f064:c3d6:5135:36e6/udp/4001/quic-v1" ];
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
        Type = "autoclient";
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
