_: {
  networking.hosts = {
    "200:6229:6335:8721:7ae1:6b30:961e:c172" = ["hydra"];
    "200:2b5a:7e80:7b31:7d15:6c81:2563:62c" = ["dagon"];
    "200:29bd:a495:4ad7:f79e:e29a:181a:3872" = ["lana"];
    "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe" = ["arc"];
  };

  networking.stevenBlackHosts = {
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
