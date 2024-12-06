_: {
  imports = [
    ./yggdrasil.nix
  ];
  programs.mosh.enable = true;
  services = {
    openssh = {
      enable = true;
      settings = {
        GatewayPorts = "yes";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    resolved.enable = true;
    zerotierone = {
      enable = true;
      joinNetworks = [ "7d36f91fa2718c7c" ];
    };
  };
  systemd.network = {
    # enable = true;
    wait-online.enable = false;
  };
  services.resolved.dnssec = "true";
  networking = {
    networkmanager.enable = true;
    nameservers = [
      "193.17.47.1"
      "185.43.135.1"
      "2001:148f:ffff::1"
      "2001:148f:fffe::1"
      "302:db60::53"
    ];
  };
  services.kubo = {
    enable = true;
    autoMount = true;
    settings = {
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
