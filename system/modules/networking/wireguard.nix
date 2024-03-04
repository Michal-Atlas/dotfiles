{ config, lib, ... }: {
  networking = {
    hosts =
      (builtins.listToAttrs
        (lib.attrsets.mapAttrsToList
          (name: value: {
            name = value.address;
            value = [ "wg-${name}" ];
          })
          config.atlasnet.wireguard));
    wireguard.interfaces.wg0 = {
      privateKeyFile = config.age.secrets.wireguard.path;
      ips = [ config.atlasnet.wireguard.${config.networking.hostName}.address ];
      peers = (lib.attrsets.mapAttrsToList
        (name: value: {
          inherit name;
          allowedIPs = [ value.address ];
          publicKey = value.key;
          endpoint = "${config.atlasnet.yggdrasil.${name}}:51820";
        })
        config.atlasnet.wireguard);
    };
  };
}
