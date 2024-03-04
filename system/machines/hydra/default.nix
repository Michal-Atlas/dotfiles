{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    ../../modules
    ./filesystems.nix
  ];
  hardware.enableAllFirmware = true;

  services.morrowind-server.enable = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "uas" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "dm-raid" ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "hydra";
  services.spotifyd.enable = true;
  age.secrets = {
    yggdrasil.file = ../../../secrets/yggdrasil/hydra.json;
    wireguard.file = ../../../secrets/wireguard/hydra;
  };
  backups = {
    preservation = "24h 31d 4w 12m";
    home-mount = "/home/";
  };
}
