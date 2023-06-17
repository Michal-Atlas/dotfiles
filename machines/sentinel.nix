{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../templates/desktop.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" "zfs" ];

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/AF43-1411";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/060d6f2d-b15c-46c5-bbc5-53ac429947f7"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostId = "e1efb5b5";

  networking.hostName = "sentinel";
}
