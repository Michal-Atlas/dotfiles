# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./home.nix
  ];

  fileSystems."/GAMES" = {
    device = "/dev/disk/by-label/Games-Z";
    fsType = "ntfs";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  networking.hostName = "hydra"; # Define your hostname.
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
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

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
    description = "Michal Atlas";
    extraGroups = [ "networkmanager" "wheel" "libvirt" "kvm" "transmission" ];
    packages = let
      emacsPackages = with pkgs.emacsPackages; [
        use-package
        org-roam
        org-roam-ui
        consult-org-roam
        #org-roam-timestamps
        engrave-faces
        go-mode
        use-package
        password-store
        password-store-otp
        org-fragtog
        org-modern
        org-superstar
        highlight-indentation
        #mode-icons
        doom-modeline
        which-key
        rainbow-identifiers
        rainbow-delimiters
        undo-tree
        ace-window
        eshell-prompt-extras
        eshell-syntax-highlighting
        esh-autosuggest
        git-gutter
        #savehist
        anzu
        marginalia
        #org-roam
        #org-roam-ui
        auto-complete
        geiser-racket
        adaptive-wrap
        geiser-guile
        sly
        slime
        geiser
        multiple-cursors
        magit
        helpful
        avy
        browse-kill-ring
        emms
        evil
        exwm
        vertico
        orderless
        consult
        xah-fly-keys
        ac-geiser
        all-the-icons
        all-the-icons-dired
        auctex
        calfw
        circe
        company
        company-box
        crux
        csv
        csv-mode
        dashboard
        debbugs
        direnv
        ediprolog
        elfeed
        elpher
        embark
        ement
        lsp-mode
        lsp-ui
        rustic
        eshell-z
        hydra
        flycheck
        flycheck-haskell
        frames-only-mode
        gdscript-mode
        haskell-mode
        highlight-indent-guides
        htmlize
        iedit
        magit-todos
        monokai-theme
        multi-term
        nix-mode
        on-screen
        ox-gemini
        #parinfer
        pdf-tools
        pg
        projectile
        racket-mode
        realgud
        swiper
        tldr
        vterm
        xkcd
        yaml-mode
        yasnippet
        yasnippet-snippets
        zerodark-theme
        gemini-mode
        nov
        dockerfile-mode
        docker
        dmenu
        eglot
        org
        stumpwm-mode
        #hackles
        yasnippet-snippets
        consult-yasnippet
        yasnippet
        tramp
        ssh-agency
        password-generator
        mastodon
        stumpwm-mode
      ];
    in with pkgs;
    [
      rare
      legendary-gl
      nixfmt
      firefox
      thunderbird
      emacs
      git
      gparted
      jetbrains.clion
      steam
      sbcl
      patchelf
      cifs-utils
      btrfs-progs
      file
      fzf
      pandoc
      texlive.combined.scheme-minimal
      htop
      gcc
      clang
      gnumake
      cmake
      meson
      python
      python39Packages.ipython
      mosh
      gnupg
      direnv
      xclip
      fasd
      bat
      exa
      pkg-config
      gdb
      chicken
      racket
      swiProlog
      lispPackages_new.sbclPackages.linedit
      vlc
      mpv
      libreoffice
      audacity
      feh
      shotwell
      inkscape
      gimp
      fira-code
      jetbrains-mono
      xorg.xrandr
      arandr
      graphviz
      xdot
      tree
      bc
      unzip
      superTuxKart
      wesnoth
      gzdoom
      taisei
      kobodeluxe
      mu
      isync
      lagrange
      youtube-dl
      okular
      discord
      xonotic
      wine
      nix-output-monitor
      minecraft
      # mathematica
      cryptsetup
      keepassxc
      valgrind

      # (pkgs.emacsWithPackagesFromUsePackage {
      # 					    package = pkgs.emacs;
      # 					   config = ./emacs.el;
      # 					   extraEmacsPackages = epkgs: [ epkgs.use-package ];
      # 					   })

    ] ++ emacsPackages;

  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.emacs = { enable = true; };
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "michal_atlas";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # services.openvpn.servers.vpn = {
  #   config = "config ${(builtins.fetchurl "https://help.fit.cvut.cz/vpn/media/fit-vpn.ovpn")}";
  #   autoStart = false;
  #   authUserPass.password = "";
  #   authUserPass.username = "zacekmi2";
  #   updateResolvConf = true;
  # };

  # fileSystems."/mnt/FIT" = {
  #   device = "//drive.fit.cvut.cz/home/zacekmi2";
  #   fsType = "cifs";
  #   options = [
  #     "sec=ntlmv2i"
  #     "file_mode=0700"
  #     "dir_mode=0700"
  #     "uid=1000"
  #     "user=zacekmi2"
  #   ];
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      virt-manager
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    #   enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
      defaultNetwork.dnsname.enable = true;
      extraPackages = [ pkgs.zfs ];
    };
  };
}
