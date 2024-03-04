{ config, ... }:
let
  prefix = "fd4c:16e4:7d9b:0";
  wgip = idx: "${prefix}::${idx}/128";
  is_self = p: p.name == config.networking.hostName;
  is_not_self = p: !(is_self p);
  peers = [
    {
      name = "hydra";
      allowedIPs = [ (wgip "1") ];
      endpoint = "yg-hydra:51820";
      publicKey = "0MigA4ewwzbwrlrZsi7+xhxn893q3nbtTPn6uiB2LEE=";
    }
    {
      name = "dagon";
      allowedIPs = [ (wgip "2") ];
      endpoint = "yg-dagon:51820";
      publicKey = "VUk71x+wmwt//38RNT47ZNFJP0ZB2xB++4bAAtT6uEU=";
    }
  ];
in
{
  networking = {
    hosts =
      builtins.listToAttrs
        (builtins.map
          (peer:
            { name = "wg-${peer.name}"; value = peer.allowedIPs; }
          )
          (builtins.filter is_not_self peers));
    wg.interfaces.wg0 = {
      privateKeyFile =
        config.age.secrets.wireguard.path;
      ips = [ (with builtins; elem 0 (filter is_self peers)) ];
      inherit peers;
    };
  };
}
