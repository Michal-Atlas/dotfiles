{
  flake,
  config,
  pkgs,
  ...
}:
{
  fileSystems."/FIT" = {
    options = flake.self.lib.automount_opts ++ [
      "uid=michal_atlas"
      "sec=ntlmv2i"
      "file_mode=0700"
      "dir_mode=0700"
      "credentials=${config.age.secrets.fit-mount.path}"
      "x-systemd.requires=openvpn-ctu-fit.service"
    ];
    device = "//drive.in.fit.cvut.cz/home/zacekmi2";
    fsType = "cifs";
  };
  age.secrets.fit-mount.file = ../secrets/fit/mount;
  age.secrets.fit-vpn.file = ../secrets/fit/vpn;
  services.openvpn.servers.ctu-fit = {
    config = ''
      config ${
        builtins.fetchurl {
          url = "https://help.fit.cvut.cz/vpn/media/fit-vpn.ovpn";
          sha256 = "sha256:0n843652fxgczfhykavxca02x057q50g911yvyy82361daally4d";
        }
      }
      auth-user-pass ${config.age.secrets.fit-vpn.path}
      up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
      up-restart
      down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
      down-pre
      pull-filter ignore redirect-gateway
      script-security 2
      # Never default already defaults to true
    '';
    autoStart = false;
  };
}
