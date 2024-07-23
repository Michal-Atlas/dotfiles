_: {
  networking.hosts = {
    "200:6229:6335:8721:7ae1:6b30:961e:c172" = [
      "cloud.michal-atlas.cz"
      "media.michal-atlas.cz"
      "gem.michal-atlas.cz"
    ];
    "127.0.0.1" = [
      "youtu.be"
      "youtube.com"
      "www.youtube.com"
      "m.youtube.com"
    ];
  };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
