{
  config,
  lib,
  ...
}: {
  networking = {
    hosts =
      builtins.listToAttrs
      (lib.attrsets.mapAttrsToList
        (name: value: {
          name = value.address;
          value = [name];
        })
        config.atlasnet.wireguard);
    wireguard.interfaces.wg0 = rec {
      privateKeyFile = config.age.secrets.wireguard.path;
      ips = [config.atlasnet.wireguard.${config.networking.hostName}.address];
      listenPort = 51820;
      peers =
        lib.attrsets.mapAttrsToList
        (name: value: {
          inherit name;
          allowedIPs = ["${value.address}/128"];
          publicKey = value.key;
          endpoint = "${config.atlasnet.yggdrasil.${name}}:${builtins.toString listenPort}";
        })
        config.atlasnet.wireguard;
    };
    firewall.allowedUDPPorts = [config.networking.wireguard.interfaces.wg0.listenPort];
  };
}
