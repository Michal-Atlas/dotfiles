{lib, ...}: let
  prefix = "fd4c:16e4:7d9b:0";
  wgip = idx: "${prefix}::${builtins.toString idx}";
in {
  options = {
    atlasnet = lib.mkOption {};
  };
  config = {
    atlasnet = {
      yggdrasil = {
        "dagon" = "200:2b5a:7e80:7b31:7d15:6c81:2563:62c";
        "hydra" = "200:6229:6335:8721:7ae1:6b30:961e:c172";
        "lana" = "200:29bd:a495:4ad7:f79e:e29a:181a:3872";
        "leviathan" = "203:2eca:327e:415d:ab2e:ab9d:6ac3:8afd";
        "arc" = "203:8b30:62b9:24a4:4af3:20cf:b37b:c4fe";
      };
      wireguard = {
        "hydra" = {
          address = wgip 1;
          key = "0MigA4ewwzbwrlrZsi7+xhxn893q3nbtTPn6uiB2LEE=";
        };
        "dagon" = {
          address = wgip 2;
          key = "VUk71x+wmwt//38RNT47ZNFJP0ZB2xB++4bAAtT6uEU=";
        };
        "leviathan" = {
          address = wgip 3;
          key = "X7oPoCCQRWm7uGesb3NvHnGDHd6Bjc2EOZSmg1a9vCA=";
        };
      };
    };
  };
}
