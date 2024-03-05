{lib, ...}: {
  options = {
    atlasnet = lib.mkOption {};
  };
  config = {
    atlasnet = {
      yggdrasil = {
        "dagon" = "200:2b5a:7e80:7b31:7d15:6c81:2563:62c";
        "hydra" = "200:6229:6335:8721:7ae1:6b30:961e:c172";
        "lana" = "200:29bd:a495:4ad7:f79e:e29a:181a:3872";
      };
    };
  };
}
