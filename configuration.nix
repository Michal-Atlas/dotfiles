{ self, config, pkgs, agenix, hostname, ... }: {
  # Should resolve double-prints
  nix.package = pkgs.nixUnstable;

  imports = [ ./cachix.nix ];
  nix.settings.trusted-users = [ "root" "michal_atlas" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  # boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

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
    relay.enable = false;
    settings = {
      devices = {
        "Nox" = {
          id = "JBRYVQP-2GYSCCK-2M37T6I-KSETJHC-UY7ZUQ5-GW56FMG-LDRDFQC-YUH5EAY";
        };
        "Hydra" = {
          id = "YNOYPTF-DBWNDGH-QW2IYSP-VIDYVFM-SGSC7DK-IMKHPN3-N4CRIEP-P5AAKQX";
        };
        "Dagon" = {
          id = "X6JNKQ7-QVHFY3K-M2SUZBO-VFFOG7I-P336TUB-KXREZKW-NI5AIWL-VMMRIAW";
        };
      };
      folders = with builtins;
        (listToAttrs
          (concatLists [
            (map
              (name:
                {
                  name = "${name}";
                  value = {
                    path = "/home/michal_atlas/${name}";
                    devices = [ "Nox" "Hydra" "Dagon" ];
                    versioning.type = "staggered";
                  };
                })
              [ "cl" "Documents" ])
            (map
              (name:
                {
                  name = "${name}";
                  value = {
                    path = "/home/michal_atlas/${name}";
                    devices = [ "Nox" "Hydra" "Dagon" ];
                  };
                })
              [
                "Sync"
                "Zotero"
              ])
          ]));
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

  nixpkgs.overlays = with self.inputs; [
    nur.overlay
    emacs-overlay.overlays.default
    (import ./atlas-emacs-overlay.nix)
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1t"
  ];

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.zsh.enable = true;
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
          if (action.id == "org.libvirt.unix.manage")
             return polkit.Result.YES;
    });
  '';

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  networking.networkmanager.connectionConfig."connection.mdns" = 2;
  services = {
    resolved.enable = true;
    avahi.enable = true;
  };

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

  services.transmission = {
    enable = true;
    settings = {
      watch-dir = "${config.users.users.michal_atlas.home}/Downloads";
      watch-dir-enabled = true;
      trash-original-torrent-files = true;
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "sourcehut:~michal_atlas/dotfiles#${hostname}";
  };

  services.borgbackup.jobs = {
    libraries = {
      user = "michal_atlas";
      paths = builtins.map (name: "/home/michal_atlas/${name}") [
        "cl"
        "Documents"
        "Zotero"
      ];
      repo = "/home/michal_atlas/borg/libs";
      prune.keep = {
        daily = 7;
        weekly = 3;
        monthly = -1;
        yearly = -1;
      };
      startAt = "06:00";
      persistentTimer = true;
      encryption.mode = "none";
    };
    tmp = {
      user = "michal_atlas";
      paths = builtins.map (name: "/home/michal_atlas/${name}") [
        "Downloads"
        "tmp"
      ];
      postCreate = ''
        ${pkgs.coreutils}/bin/rm -r /home/michal_atlas/{tmp,Downloads}
        ${pkgs.coreutils}/bin/mkdir /home/michal_atlas/{tmp,Downloads}
      '';
      repo = "/home/michal_atlas/borg/tmps";
      prune.keep = { daily = -1; };
      startAt = "06:00";
      persistentTimer = true;
      encryption.mode = "none";
    };
  };
}
