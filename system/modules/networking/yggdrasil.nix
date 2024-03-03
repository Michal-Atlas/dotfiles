{ config, ... }:
{
  networking.hosts =
    let conc = l: [ (builtins.concatStringsSep ":" l) ]; in
    {
      "yg-hydra" = conc [
        "200"
        "6229"
        "6335"
        "8721"
        "7ae1"
        "6b30"
        "961e"
        "c172"
      ];
      "yg-dagon" = conc [
        "200"
        "2b5a"
        "7e80"
        "7b31"
        "7d15"
        "6c81"
        "2563"
        "62c"
      ];
      "yg-lana" = conc [
        "200"
        "29bd"
        "a495"
        "4ad7"
        "f79e"
        "e29a"
        "181a"
        "3872"
      ];
    };
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
