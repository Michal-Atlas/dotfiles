# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../templates/desktop.nix
    ../templates/morrowind-server.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "uas" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "dm-raid" ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/C9ED-A99E";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/1a20f616-635b-46af-bf07-ff09cf461504"; }];

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

  services.btrfs.autoScrub.enable = true;
  fileSystems = {
    "/" = {
      device = "/dev/spool/root";
      options = [ "subvol=@nix" ];
      fsType = "btrfs";
    };
    "/home" = {
      device = "/dev/rpool/home";
      options = [ "subvol=@home" ];
      fsType = "btrfs";
    };
    "/home/michal_atlas/Games" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@games" ];
      fsType = "btrfs";
    };
    "/home/michal_atlas/Downloads" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@tmp" ];
      fsType = "btrfs";
    };
    "/home/michal_atlas/tmp" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@tmp" ];
      fsType = "btrfs";
    };
    "/var/lib/ipfs" = {
      device = "/dev/rpool/vault";
      options = [ "subvol=@ipfs" ];
      fsType = "btrfs";
    };
  };
}
