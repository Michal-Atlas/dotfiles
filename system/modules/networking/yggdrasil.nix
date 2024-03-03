{ config, ... }:
{
  age.secrets.yggdrasil.file = ../../../secrets/yggdrasil/${config.networking.hostName}.json;
  services.yggdrasil = {
    enable = true;
    group = "wheel";
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
