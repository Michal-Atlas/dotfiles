_: {
  imports = [
    ./hosts.nix
    ./torrents.nix
    ./yggdrasil.nix
    ./morrowind.nix
    # ./wireguard.nix
  ];
  services = {
    openssh = {
      enable = true;
      settings.GatewayPorts = "yes";
    };
    resolved.enable = true;
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
