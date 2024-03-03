{ config, ... }:
let
  prefix = "fd4c:16e4:7d9b:0";
  wgip = idx: "${prefix}::${idx}/128";
  peers = [
    {
      name = "hydra";
      allowedIPs = [ (wgip 1) ];
      endpoint = "yg-hydra:51820";
      publicKey = "0MigA4ewwzbwrlrZsi7+xhxn893q3nbtTPn6uiB2LEE=";
    }
    {
      name = "dagon";
      allowedIPs = [ (wgip 2) ];
      endpoint = "yg-dagon:51820";
      publicKey = "VUk71x+wmwt//38RNT47ZNFJP0ZB2xB++4bAAtT6uEU=";
    }
  ];
in
{
  age.secrets.wireguard.file = ../../../secrets/wireguard/${config.networking.hostName};
  networking = {
    hosts =
      builtins.listToAttrs
        (builtins.map
          (peer:
            { name = "wg-${peer.name}"; value = peer.allowedIPs; }
          )
          peers);
    wg-quick.interfaces.wg0 = {
      privateKeyFile =
        age.secrets.wireguard.path;
      address = wgip 2;
      inherit peers;
    };
  };
}
