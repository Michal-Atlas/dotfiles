_:
{
  networking.hosts = {
    "200:aa4d:e2e3:5360:2ee8:7b99:984f:155f" = [ "hydra" ];
    "202:8a79:d8dc:19dd:d045:e857:6637:f8af" = [ "dagon" ];
    "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe" = [ "arc" ];
  } //
  (builtins.foldl' (acc: addr: acc // { "0.0.0.0" = [ addr ]; "::0" = [ addr ]; })
    { }
    [
      "reddit.com"
      "www.youtube.com"
      "m.youtube.com"
      "youtu.be"
    ]);

  networking.stevenBlackHosts = {
    enable = true;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
