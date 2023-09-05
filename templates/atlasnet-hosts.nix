_: {
  networking.hosts = {
    "201:a50e:ca2d:72bf:89aa:e12:e14d:f2e6" = [ "hydra" ];
    "200:ac59:de15:abe5:650e:7139:f561:c2fb" = [ "dagon" ];
    "200:29bd:a495:4ad7:f79e:e29a:181a:3872" = [ "lana" ];
    "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe" = [ "arc" ];
  };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
  };
}
