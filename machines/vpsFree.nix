{
  config,
  lib,
  ...
}:
{
  imports = [
    ../modules/user.nix
    ../modules/networking
    ../modules/nix.nix
  ];
  networking.hostName = "vorpal";
  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "x86_64-linux";
  };
  system.stateVersion = "24.11";
  home-manager.users."michal_atlas" = {
    home.packages = [ ];
    programs = {
      firefox.enable = lib.mkForce false;
      gnome-shell.enable = lib.mkForce false;
      thunderbird.enable = lib.mkForce false;
    };
    services.emacs.enable = lib.mkForce false;
    programs.emacs.enable = lib.mkForce false;
    dconf.enable = lib.mkForce false;
  };
  services.yggdrasil.settings = {
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
  networking.firewall.allowedTCPPorts = [
    993
  ];
  services = {
    kubo.enable = lib.mkForce false;
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
              proxyPass = "http://hydra:8080";
              extraConfig = "proxy_read_timeout = 1h;";
            };
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
