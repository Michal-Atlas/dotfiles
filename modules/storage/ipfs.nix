_: {
  services.kubo = {
    enable = true;
    localDiscovery = true;
    autoMount = true;
    settings.Addresses.API = ["/ip4/127.0.0.1/tcp/5001"];
  };
  networking.firewall.allowedTCPPorts = [4001];
}
