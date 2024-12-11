{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../modules
    #    ./mailman.nix
  ];
  networking.hostName = "vorpal";
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "24.11";
  home-manager.users."michal_atlas" = {
    home.defaultPackages = false;
    programs = {
      firefox.enable = false;
      gnome-shell.enable = false;
      thunderbird.enable = false;
    };
    emacs.enable = false;
    dconf.enable = false;
  };

  hardware.enable = false;
  programs.steam.enable = false;
  services = {
    kubo.settings = {
      Addresses.Announce = [
        "/ip4/37.205.15.189/udp/4001/quic-v1"
        "/ip4/37.205.15.189/udp/4001/quic-v1/webtransport"
        "/ip6/2a03:3b40:fe:833::1/udp/4001/quic-v1"
        "/ip6/2a03:3b40:fe:833::1/udp/4001/quic-v1/webtransport"
      ];
      Gateway.PublicGateways."ipfs.michal-atlas.cz" = {
        Paths = [
          "/ipfs"
          "/ipns"
        ];
        UseSubdomains = false;
      };
      Reprovider.Interval = "22h";
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
      ];
      MulticastInterfaces = lib.mkForce [ ];
    };
    syncthing.enable = false;
    gvfs.enable = false;
  };
  networking.firewall.allowedTCPPorts = [
    993
    80
    443
    1965
  ];

  services = {
    book-dagon.enable = true;
    kineto = {
      enable = true;
      port = 4859;
      geminiDomain = "gemini://blog.michal-atlas.cz";
    };
    molly-brown =
      let
        dir = config.security.acme.certs."blog.michal-atlas.cz".directory;
      in
      {
        enable = true;
        hostName = "blog.michal-atlas.cz";
        certPath = "${dir}/cert.pem";
        keyPath = "${dir}/key.pem";
        docBase = pkgs.fetchFromSourcehut {
          owner = "~michal_atlas";
          repo = "www";
          rev = "992dbc2f5dc9b1ca5324ec644059c11537e7462b";
          hash = "sha256-CtZdgsfA4YI7S5gd9opSaxNoPEaDX5Ydaa9mW7G2mfc=";
        };
      };
    nginx =
      let
        defaults = {
          enableACME = true;
          forceSSL = true;
          http2 = true;
          http3 = true;
        };
      in
      {
        enable = true;
        virtualHosts = {
          "fin.michal-atlas.cz" = defaults // {
            locations."/".proxyPass = "http://hydra:8096";
          };
          "blog.michal-atlas.cz" = defaults // {
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
  systemd.services.molly-brown.serviceConfig.SupplementaryGroups = [
    config.security.acme.certs."blog.michal-atlas.cz".group
  ];
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "me+acme@michal-atlas.cz";
    };
  };
}
