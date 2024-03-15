{
  config,
  lib,
  nixos-hardware,
  ...
}: {
  imports = [
    ../../modules
    ./filesystems.nix
    ./builds.nix
    nixos-hardware.nixosModules.dell-inspiron-14-5420
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
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs" "zfs"];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    hostName = "dagon";
    hostId = "253520d6";
  };
  age.secrets = {
    yggdrasil.file = ../../secrets/yggdrasil/dagon.json;
    wireguard.file = ../../secrets/wireguard/dagon;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  services.thermald.enable = true;
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    scsiLinkPolicy = "min_power";
    powertop.enable = true;
  };
}