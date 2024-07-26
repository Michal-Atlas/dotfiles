_: {
  networking.hosts = {
    "200:6229:6335:8721:7ae1:6b30:961e:c172" = [
      "cloud.michal-atlas.cz"
      "media.michal-atlas.cz"
      "gem.michal-atlas.cz"
    ];
  };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
