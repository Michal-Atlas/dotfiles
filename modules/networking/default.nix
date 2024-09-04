_: {
  imports = [
    ./hosts.nix
    ./yggdrasil.nix
    ./morrowind.nix
    ./mounts.nix
    ./atlasnet.nix
    ./wireguard.nix
  ];
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
  networking = {
    networkmanager.enable = true;
    nameservers = [
      "193.17.47.1"
      "185.43.135.1"
      "302:db60::53"
    ];
  };
}
