{ config, ... }: {
  age.secrets.fit-vpn.file = ../secrets/fit-vpn.age;
  age.secrets.fit-mount.file = ../secrets/fit-mount.age;
  services.openvpn.servers.ctu-fit = {
    config = ''
      config ${
        builtins.fetchurl {
          url = "https://help.fit.cvut.cz/vpn/media/fit-vpn.ovpn";
          sha256 =
            "sha256:0n843652fxgczfhykavxca02x057q50g911yvyy82361daally4d";
        }
      }
      auth-user-pass ${config.age.secrets.fit-vpn.path}
      pull-filter ignore redirect-gateway
    '';
    # autoStart = false;
    updateResolvConf = true;
  };

  fileSystems."/FIT" = {
    device = "//drive.fit.cvut.cz/home/zacekmi2";
    fsType = "cifs";
    options = [
      "sec=ntlmv2i"
      "file_mode=0700"
      "dir_mode=0700"
      "uid=1000"
      "credentials=${config.age.secrets.fit-mount.path}"
      "x-systemd.requires=openvpn-ctu-fit.service"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
    ];
  };
}
