{ pkgs, config, ... }:
{
  services.openvpn.servers.ctu-fit = {
    config = ''
      config ${
        builtins.fetchurl {
          url = "https://help.fit.cvut.cz/vpn/media/fit-vpn.ovpn";
          sha256 = "sha256:0n843652fxgczfhykavxca02x057q50g911yvyy82361daally4d";
        }
      }
      auth-user-pass /root/fit-vpn
      up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
      up-restart
      down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
      down-pre
      pull-filter ignore redirect-gateway
      script-security 2
      ipv4.never-default true
      ipv6.never-default true
    '';
    autoStart = false;
  };
  fileSystems."/FIT" = {
    device = "//drive.in.fit.cvut.cz/home/zacekmi2";
    fsType = "cifs";
    options = [
      "sec=ntlmv2i"
      "file_mode=0700"
      "dir_mode=0700"
      "uid=${builtins.toString config.users.users.michal_atlas.uid}"
      "credentials=/root/fit-mount"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "x-systemd.requires=openvpn-ctu-fit.service"
    ];
  };
}
