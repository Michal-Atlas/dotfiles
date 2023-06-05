_: {
  networking.hosts =
    let
      blocklinks = [ "reddit.com" "www.youtube.com" "m.youtube.com" "youtu.be" "deviantart.com" ];
    in
    {
      "200:aa4d:e2e3:5360:2ee8:7b99:984f:155f" = [ "hydra" ];
      "202:8a79:d8dc:19dd:d045:e857:6637:f8af" = [ "dagon" ];
      "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe" = [ "arc" ];
    } //
    {
      "0.0.0.0" = blocklinks;
      "::0" = blocklinks;
    };

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
