_: {
  networking.hosts = {
    "37.205.15.189" = [
      "vorpal"
      "vorpal.ip4"
    ];
    "2a03:3b40:fe:833::1" = [
      "vorpal"
      "vorpal.ip6"
    ];
    "200:299c:6b1a:c8ac:bc4d:d2be:cbd:6014" = [ "leviathan" ];
    "201:876c:b6b:3561:f064:c3d6:5135:36e6" = [ "hydra" ];
  };

  networking.stevenblack.enable = true;
}
