{
  flake,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./sourcehut.nix
  ];
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
  services = {
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

  services = {
    book-dagon.enable = false;
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
          root = "${flake.inputs.www.packages.${pkgs.system}.blog}";
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
            locations."/".proxyPass =
              let
                cfg = config.services.kineto;
              in
              "http://${cfg.address}:${builtins.toString cfg.port}";
          };
          "fff.michal-atlas.cz" = defaults // {
            locations."/".proxyPass = "http://localhost:${builtins.toString config.services.book-dagon.port}";
          };
        };
      };
  };
}
