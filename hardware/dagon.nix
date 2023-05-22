# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/23d5e34f-31e4-49c9-9cda-e0e6926ead16";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  boot.initrd.luks.devices."NIX".device = "/dev/disk/by-uuid/8838b842-e06e-4419-bc21-cfe5a3038a7b";
  boot.initrd.luks.devices."NIXSWAP".device = "/dev/disk/by-uuid/a86f8b98-8849-4fbc-882b-576fa2f0a591";

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/23d5e34f-31e4-49c9-9cda-e0e6926ead16";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/E22E-4071";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/aff3245a-6b95-401a-ad2a-01716efadcdd"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
