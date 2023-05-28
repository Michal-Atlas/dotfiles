{ ... }:
{
  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    group = "wheel";

    settings = {
      Peers = [
        "tls://[2a03:3b40:fe:ab::1]:993"
        "tls://37.205.14.171:993"
        "tcp://195.123.245.146:7743"
        "tcp://[2a05:9403::8b]:7743"
        "tcp://193.107.20.230:7743"
      ];
    };
  };
}
