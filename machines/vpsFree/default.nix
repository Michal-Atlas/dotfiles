{
  flake,
  pkgs,
  config,
  lib,
  ...
}:
let
  wwwPkgs = flake.inputs.www.packages.${pkgs.system};
in
{
  imports = [ ./social.nix ];
  nix.gc.options = "--delete-older-than 4d";
  networking = {
    hostName = "vorpal";
    domain = "michal-atlas.cz";
  };
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "24.11";
  systemd.services.ipfs.environment.GOMEMLIMIT = "1GiB";
  services.fail2ban.enable = true;
  services = {
    kubo = {
      localDiscovery = false;
      enableGC = true;
      settings = {
        Routing = {
          Type = "autoclient";
          AcceleratedDHTClient = false;
        };
        Addresses.Announce = [
          "/ip4/37.205.15.189/udp/4001/quic-v1"
          "/ip4/37.205.15.189/udp/4001/quic-v1/webtransport"
          "/ip6/2a03:3b40:fe:833::1/udp/4001/quic-v1"
          "/ip6/2a03:3b40:fe:833::1/udp/4001/quic-v1/webtransport"
        ];
        Gateway = {
          # NoFetch = true;
          PublicGateways."ipfs.michal-atlas.cz" = {
            Paths = [
              "/ipfs"
              "/ipns"
            ];
            UseSubdomains = false;
          };
        };
        Reprovider.Interval = "0h";
        Swarm = {
          RelayClient.Enabled = false;
          RelayService.Enabled = false;
          ResourceMgr.MaxMemory = "68719476736";
        };
      };
    };
    yggdrasil.settings = {
      Peers = lib.mkForce [
        # Czechia
        "tls://[2a03:3b40:fe:ab::1]:993"
        "tls://37.205.14.171:993"
        # Germany
        "tcp://193.107.20.230:7743"
      ];
      Listen = [
        "tls://0.0.0.0:993"
        "tls://[::]:993"
      ];
      MulticastInterfaces = lib.mkForce [ ];
    };
  };
  networking.firewall.allowedTCPPorts = [
    993
    80
    443
    1965
  ];
  systemd.services.ipfs-gemini-gateway = {
    script = "${
      flake.inputs.ipfs-gemini-gateway.packages.${pkgs.system}.default
    }/bin/ipfs-gemini-gateway";
    wantedBy = [ "multi-user.target" ];
  };
  services = {
    book-dagon.enable = true;
    kineto = {
      enable = true;
      port = 4859;
      geminiDomain = "gemini://blog.michal-atlas.cz";
      extraArgs = [
        "-e"
        "/assets/style.css"
      ];
    };
    stargazer = {
      enable = true;
      ipLog = true;
      routes = [
        {
          route = "blog.michal-atlas.cz";
          root = "${wwwPkgs.blog}";
        }
        {
          route = "ipfs.michal-atlas.cz";
          scgi = true;
          scgi-address = "127.0.0.1:1966";
        }
      ];
    };
    nginx =
      let
        defaults = flake.self.lib.nginxDefaults;
      in
      {
        enable = true;
        virtualHosts = {
          "fin.michal-atlas.cz" = defaults // {
            locations."/".proxyPass = "http://hydra:8096";
          };
          "blog.michal-atlas.cz" = defaults // {
            # For some reason Kineto returns 404 on this
            locations."/favicon.ico" = {
              root = wwwPkgs.blog;
              index = "favicon.ico";
            };
            locations."/".proxyPass =
              let
                cfg = config.services.kineto;
              in
              "http://${cfg.address}:${builtins.toString cfg.port}";
          };
          "ipfs.michal-atlas.cz" = defaults // {
            locations."/" = {
              proxyPass = "http://localhost:8080";
              extraConfig = ''
                proxy_read_timeout 1h;
              '';
            };
          };
          "fff.michal-atlas.cz" = defaults // {
            locations."/".proxyPass = "http://localhost:${builtins.toString config.services.book-dagon.port}";
          };
        };
      };
  };
}
