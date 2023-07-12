{ pkgs, ... }: {

  # imports = [ ../templates/morrowind-server.nix ];

  system.stateVersion = "23.05";
  networking.hostName = "rpi";
  nixpkgs = {
    config.allowUnsupportedSystem = true;
    hostPlatform.system = "armv7l-linux";
    buildPlatform.system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];
  };

  services = {
    openssh.enable = true;
    resolved = {
      enable = true;
      llmnr = "false";
    };
    zerotierone = {
      enable = true;
      joinNetworks = [ "c7c8172af19f63d7" ];
    };
  };
  networking = {
    firewall.enable = false;
    # networkmanager.enable = true;
  };
  boot.growPartition = true;
  # systemd.services."tes3mp-server" = {
  #   wants = [ "network.target" ];
  #   after = [ "syslog.target" "network-online.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   environment = {
  #     XDG_CONFIG_HOME = "/tes3mp/config";
  #     XDG_DATA_HOME = "/tes3mp/data";
  #   };
  #   script = "${pkgs.openmw-tes3mp}/bin/tes3mp-server";
  # };
}
