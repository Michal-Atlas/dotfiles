# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  networking.hostName = "hydra";
  nix.settings.trusted-users = [ "michal_atlas" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];

  systemd.services."tes3mp-server" = {
    wants = [ "network.target" ];
    after = [ "syslog.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Group = "tes3mp";
    };
    environment = {
      XDG_CONFIG_HOME = "/rpool/tes3mp/config";
      XDG_DATA_HOME = "/rpool/tes3mp/data";
    };
    script = "${pkgs.openmw-tes3mp}/bin/tes3mp-server";
  };
}
