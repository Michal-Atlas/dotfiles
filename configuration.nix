# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ self, config, pkgs, agenix, ... }: {
  # Should resolve double-prints
  nix.package = pkgs.nixUnstable;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.extraHosts = ''
    192.168.0.100 hydra
    192.168.0.101 dagon
  '';

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    #   LC_ADDRESS = "cs_CZ.UTF-8";
    #   LC_IDENTIFICATION = "cs_CZ.UTF-8";
    #   LC_MEASUREMENT = "cs_CZ.UTF-8";
    #   LC_MONETARY = "cs_CZ.UTF-8";
    #   LC_NAME = "cs_CZ.UTF-8";
    #   LC_NUMERIC = "cs_CZ.UTF-8";
    #   LC_PAPER = "cs_CZ.UTF-8";
    #   LC_TELEPHONE = "cs_CZ.UTF-8";
    #   LC_TIME = "cs_CZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  # https://nixos.wiki/wiki/AMD_GPU
  systemd.tmpfiles.rules =
    [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}" ];

  hardware.opengl = {
    driSupport = true;
    # For 32 bit applications
    driSupport32Bit = true;
    extraPackages = with pkgs; [ rocm-opencl-icd rocm-opencl-runtime amdvlk ];
    # For 32 bit applications
    # Only available on unstable
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk libva ];
    setLdLibraryPath = true;
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us,cz";
    xkbVariant = ",ucw";
    xkbOptions = "grp:caps_switch,lv3:ralt_switch,compose:rctrl-altgr";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # system.nssModules = pkgs.lib.optional true pkgs.nssmdns;
  # system.nssDatabases.hosts = pkgs.lib.optionals true (pkgs.lib.mkMerge [
  #   (pkgs.lib.mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
  #   (pkgs.lib.mkAfter [ "mdns4" ]) # after dns
  # ]);

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "c7c8172af19f63d7" ];
  };

  services.syncthing = {
    enable = true;
    user = "michal_atlas";
    dataDir =
      "/home/michal_atlas/Documents"; # Default folder for new synced folders
    configDir =
      "/home/michal_atlas/.config/syncthing"; # Folder for Syncthing's settings and keys
    overrideDevices =
      true; # overrides any devices added or deleted through the WebUI
    overrideFolders =
      true; # overrides any folders added or deleted through the WebUI
    devices = {
      "Nox" = {
        id = "JBRYVQP-2GYSCCK-2M37T6I-KSETJHC-UY7ZUQ5-GW56FMG-LDRDFQC-YUH5EAY";
      };
      "Hydra" = {
        id = "OQAFX4X-3AWLM54-YHMTL6E-O6VGWE7-TPCJM4Y-PVCIDVE-FK6RFHU-EWCMMQJ";
      };
      "Dagon" = {
        id = "7E2VZAO-XITSGIJ-LRHC6BQ-QUO6FA6-NPT5Q5P-4I7HTOR-PPW5757-GQMXZAL";
      };
    };
    folders = {
      "documents" = {
        path = "/home/michal_atlas/Documents";
        devices = [ "Nox" "Hydra" "Dagon" ];
      };
      "sync" = {
        path = "/home/michal_atlas/Sync";
        devices = [ "Nox" "Hydra" "Dagon" ];
      };
      "cl" = {
        path = "/home/michal_atlas/cl";
        devices = [ "Nox" "Hydra" "Dagon" ];
      };
      "roam" = {
        path = "/home/michal_atlas/roam";
        devices = [ "Nox" "Hydra" "Dagon" ];
      };
      "music" = {
        path = "/home/michal_atlas/Music";
        devices = [ "Nox" "Hydra" "Dagon" ];
      };
      "zotero" = {
        path = "/home/michal_atlas/Zotero";
        devices = [ "Nox" "Hydra" "Dagon" ];
      };
    };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michal_atlas = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Michal Atlas";
    extraGroups = [ "networkmanager" "wheel" "libvirt" "kvm" "transmission" ];
    openssh.authorizedKeys.keys = with builtins;
      (map (f: readFile ./keys/${f}) (attrNames (readDir ./keys)));
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "michal_atlas";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # age.secrets.fit-vpn.file = ./secrets/fit-vpn.age;
  # age.secrets.fit-mount.file = ./secrets/fit-mount.age;
  # services.openvpn.servers.ctu-fit = {
  #   config = ''
  #     config ${
  #       (builtins.fetchurl {
  #         url = "https://help.fit.cvut.cz/vpn/media/fit-vpn.ovpn";
  #         sha256 =
  #           "sha256:0n843652fxgczfhykavxca02x057q50g911yvyy82361daally4d";
  #       })
  #     }
  #     auth-user-pass ${config.age.secrets.fit-vpn.path}
  #   '';
  #   autoStart = false;
  #   updateResolvConf = true;
  # };

  # fileSystems."/FIT" = {
  #   device = "//drive.fit.cvut.cz/home/zacekmi2";
  #   fsType = "cifs";
  #   options = [
  #     "sec=ntlmv2i"
  #     "file_mode=0700"
  #     "dir_mode=0700"
  #     "uid=1000"
  #     "credentials=${config.age.secrets.fit-mount.path}"
  #     "x-systemd.requires=openvpn-ctu-fit.service"
  #   ];
  # };

  nixpkgs.overlays = with self.inputs;
    [
      nix-alien.overlays.default
      # emacs-overlay.overlay
    ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  environment.systemPackages = [ agenix.packages.x86_64-linux.default ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  programs.dconf.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      extraPackages = [ pkgs.zfs ];
    };
  };
  nix.settings.auto-optimise-store = true;

  systemd.user = {
    timers = {
      "tmp-log" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1d";
          onUnitActiveSec = "1d";
          Unit = "tmp-log.service";
        };
      };

      "mailsync" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "20m";
          onUnitActiveSec = "20m";
          Unit = "mailsync.service";
        };
      };
    };

    services = {
      "mailsync" = {
        script = "mbsync --all";
        serviceConfig = { Type = "oneshot"; };
        path = with pkgs; [ isync gnupg ];
      };
      "tmp-log" = {
        script = ''
          mkdir -p "$HOME/tmp-log";
          if [ "$(ls -A "$HOME/tmp")" ]; then
              mv "$HOME/tmp" "$HOME/tmp-log/$(date -I)";
              mkdir -p "$HOME/tmp";
          fi;
          if [ "$(ls -A "$HOME/Downloads")" ]; then
              mv "$HOME/Downloads" "$HOME/tmp-log/$(date -I)-down";
              mkdir -p "$HOME/Downloads";
          fi;
        '';
        serviceConfig = { Type = "oneshot"; };
      };
    };
  };

  services.transmission = {
    enable = true;
    settings = {
      watch-dir = "${config.users.users.michal_atlas.home}/Downloads";
      watch-dir-enabled = true;
      trash-original-torrent-files = true;
    };
  };
}
