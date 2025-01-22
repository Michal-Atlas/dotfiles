{
  config,
  lib,
  pkgs,
  flake,
  ...
}:
{
  imports = [
    ./filesystems.nix
  ];
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  services = {
    morrowind-server.enable = false;
    syncthing.settings.options.maxSendKbps = 4096 * 20;
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    xserver.videoDrivers = [ "amdgpu" ];
    atftpd = {
      enable = true;
      extraOptions = [
        "--bind-address 192.168.0.60"
        "--verbose=7"
      ];
    };
  };

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
        9000 # peertube
      ];
      allowedUDPPorts = [
        69 # tftp
        5353
      ];
    };
  };

  systemd = {
    # https://nixos.wiki/wiki/AMD_GPU
    tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  };
  home-manager.users.michal_atlas = {
    wayland.windowManager.hyprland.settings.monitor = [
      "DP-2, preferred, auto-right, 1"
    ];
    services = {
      spotifyd = {
        enable = true;
        settings.global = {
          zeroconf_port = 1234;
          use_keyring = false;
          use_mpris = false;
          volume_normalisation = true;
          bitrate = 320;
        };
      };
    };
  };
  environment.systemPackages = [
    flake.inputs.nixified-ai.packages.${pkgs.system}.invokeai-amd
  ];
  nix = {
    settings.trusted-users = [ "nix-ssh" ];
    sshServe = {
      enable = true;
      inherit (config.users.users.michal_atlas.openssh.authorizedKeys) keys;
      write = true;
    };
  };
}
