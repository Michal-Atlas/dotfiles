{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    ../../modules
    ./filesystems.nix
    ./builds.nix
  ];
  hardware.enableAllFirmware = true;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    # Should speed up LUKS
    "aesni_intel"
    "cryptd"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "dagon";
  age.secrets = {
    yggdrasil.file = ../../../secrets/yggdrasil/dagon.json;
    wireguard.file = ../../../secrets/wireguard/dagon;
  };
    backups = {
    preservation = "24h 7d";
    home-mount = "/home/michal_atlas/";
  };
}
