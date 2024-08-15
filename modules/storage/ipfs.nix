{
  pkgs,
  config,
  ...
}: {
  services.kubo = {
    enable = true;
    localDiscovery = true;
    autoMount = true;
    settings = {
      Addresses = {
        API = ["/ip4/127.0.0.1/tcp/5001"];
        AppendAnnounce = [
          "/ip6/${builtins.getAttr
            config.networking.hostName
            config.atlasnet.yggdrasil}/tcp/4001"
        ];
      };
      AutoNAT.ServiceMode = "disabled";
    };
  };
  networking.firewall = {
    allowedTCPPorts = [4001 9096];
    allowedUDPPorts = [4001];
  };
  systemd.user.services.ipfs-cluster = {
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ipfs-cluster}/bin/ipfs-cluster-service daemon";
    };
  };
}
