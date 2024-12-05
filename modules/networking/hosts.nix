_: {
  networking.hosts = {
    "37.205.15.189" = [ "vorpal" ];
    "2a03:3b40:fe:833::1" = [ "vorpal" ];
    "200:299c:6b1a:c8ac:bc4d:d2be:cbd:6014" = [ "leviathan" ];
    "200:8c2a:3279:eb5d:f3eb:eb7f:d3a3:29d4" = [ "hydra" ];
  };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
