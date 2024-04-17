{
  config,
  lib,
  ...
}: {
  imports = [
    ../../modules
    ./filesystems.nix
    "${fetchTarball {
      url = "https://github.com/onny/nixos-nextcloud-testumgebung/archive/fa6f062830b4bc3cedb9694c1dbf01d5fdf775ac.tar.gz";
      sha256 = "0gzd0276b8da3ykapgqks2zhsqdv4jjvbv97dsxg0hgrhb74z0fs";
    }}/nextcloud-extras.nix"
    ./nextcloud.nix
  ];
  hardware.enableAllFirmware = true;

  services.morrowind-server.enable = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "uas" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot" "dm-raid"];
  boot.kernelModules = ["kvm-amd" "amdgpu"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["ntfs" "zfs"];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    hostName = "hydra";
    hostId = "44b7fc7c";
  };

  age.secrets = {
    yggdrasil.file = ../../secrets/yggdrasil/hydra.json;
    wireguard.file = ../../secrets/wireguard/hydra;
    kite.file = ../../secrets/kite;
  };
}
