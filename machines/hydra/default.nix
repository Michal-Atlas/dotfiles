{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules
    ./filesystems.nix
  ];
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services = {
    morrowind-server.enable = false;
    syncthing.settings.options.maxSendKbps = 4096 * 20;
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "uas"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [
        "dm-snapshot"
        "dm-raid"
      ];
    };
    kernelModules = [
      "kvm-amd"
      "amdgpu"
    ];
    extraModulePackages = [ ];
    supportedFilesystems = [
      "ntfs"
      "zfs"
    ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking = {
    hostName = "hydra";
    hostId = "44b7fc7c";
    firewall = {
      allowedTCPPorts = [
        1234 # spotify
        57621
      ];
      allowedUDPPorts = [ 5353 ];
    };
  };

  age.secrets = {
    yggdrasil.file = ../../secrets/yggdrasil/hydra.json;
    wireguard.file = ../../secrets/wireguard/hydra;
  };
  systemd = {
    # https://nixos.wiki/wiki/AMD_GPU
    tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  };
  hardware.opengl = {
    driSupport = true;
    # For 32 bit applications
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];
    # For 32 bit applications
    # Only available on unstable
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
      libva
    ];
    setLdLibraryPath = true;
  };
  home-manager.users.michal_atlas = {
    services = {
      spotifyd = {
        enable = true;
        settings.global = {
          zeroconf_port = 1234;
          use_keyring = false;
          use_mpris = false;
          volume_normalisation = true;
        };
      };
    };
    dconf.settings = {
      "org/gnome/desktop/screensaver".lock-enabled = false;
      "org/gnome/desktop/notifications".show-in-lock-screen = false;
    };
  };
  services.kubo.settings = {
    Routing = {
      AcceleratedDHTClient = false;
      Type = "auto";
    };
    Reprovider = {
      Interval = "0h";
      Strategy = "all";
    };
    Swarm.ConnMgr = {
      LowWater = 32;
      HighWater = 96;
    };
  };
}
