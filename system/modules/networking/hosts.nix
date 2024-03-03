_: {
  networking.hosts = {
    "201:a50e:ca2d:72bf:89aa:e12:e14d:f2e6" = [ "hydra" ];
    "200:a3ee:7e54:10e9:c0d6:47db:90a:5ed5" = [ "dagon" ];
    "200:29bd:a495:4ad7:f79e:e29a:181a:3872" = [ "lana" ];
    "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe" = [ "arc" ];
  };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
