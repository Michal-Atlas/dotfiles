{
  config,
  lib,
  ...
}:
{
  imports = [
    ../modules
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
    kubo.settings.Addresses.Announce = [
      "/ip4/37.205.15.189/udp/4001/quic-v1"
      "/ip6/2a03:3b40:fe:833::1/udp/4001/quic-v1"
    ];
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
  ];

  services = {
    book-dagon.enable = true;
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
          "ipfs.michal-atlas.cz" = defaults // {
            locations."/" = {
              proxyPass = "http://localhost:8080";
              extraConfig = ''
                proxy_read_timeout 1h;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              '';
            };
          };
          "fff.michal-atlas.cz" = defaults // {
            locations."/".proxyPass = "http://localhost:${builtins.toString config.services.book-dagon.port}";
          };
        };
      };
  };
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "me+acme@michal-atlas.cz";
      # Staging environment
      server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    };
  };
}
