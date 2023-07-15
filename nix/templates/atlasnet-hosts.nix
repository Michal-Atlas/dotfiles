_: {
  networking.hosts = {
    "202:6c78:85c6:d5d0:5cd:4414:e803:4278" = [ "hydra" ];
    "200:be8a:eec:19b0:d3e7:7016:eec4:eb84" = [ "dagon" ];
    "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe" = [ "arc" ];
  };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
