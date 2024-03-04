{ config, lib, ... }: {
  networking.hosts = (builtins.listToAttrs
    (lib.attrsets.mapAttrsToList
      (name: value: {
        value = [ name ];
        name = value;
      })
      config.atlasnet.yggdrasil));
  services.yggdrasil = {
    enable = true;
    group = "wheel";
    openMulticastPort = true;
    configFile = config.age.secrets.yggdrasil.path;

    settings.Peers = [
      # Czechia
      "tls://[2a03:3b40:fe:ab::1]:993"
      "tls://37.205.14.171:993"
      # Germany
      "tcp://193.107.20.230:7743"
    ];
  };
}
