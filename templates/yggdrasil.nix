{ ... }:
{
  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    group = "wheel";

    settings = {
      Peers = [
        # Czechia
        "tls://[2a03:3b40:fe:ab::1]:993"
        "tls://37.205.14.171:993"
        # Germany
        "tcp://193.107.20.230:7743"
      ];
    };
  };
}
