{ ... }:
{
  imports = [
    ./yggdrasil.nix
    ./hosts.nix
    ./morrowind.nix
    ./mounts.nix
    ./ipfs.nix
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
  services.nginx = {
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedZstdSettings = true;
    statusPage = true;
  };
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "me+acme@michal-atlas.cz";
    };
  };
}
