(define-module (atlas packages system)
  #:use-module (gnu packages)
  #:export (%system-desktop-manifest))

(define %system-desktop-manifest-list
  `(
    "nvi" "patchelf"
    
    ;; DE
    "xnotify" "brightnessctl" "pamixer" "playerctl"
    "firefox" "xscreensaver" "gparted"
    "pavucontrol" "screen"
    "sway"
    "i3status" "i3lock"
    "flatpak" "font-fira-code"
    "breeze-icons" "hicolor-icon-theme"
    "adwaita-icon-theme"
    ;; Emacs
    "emacs-next"
    "emacs-exwm"
    
    ;; Libs
    "ncurses" "curl" "virt-manager"
    "ntfs-3g" "btrfs-progs"
    "cifs-utils"

    ;; Shell utils
    "file" "screen"
    "kitty" "fzf"
    "pandoc" "zutils"
    "vim" "zsh" "git" "htop"
    
    ;; Toolchains
    "gcc-toolchain" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh" "luajit" "perl" "nix"

    "openvpn" "network-manager-openvpn"
    "gnupg" "pinentry"    
    "nss-certs" "xdg-utils"))

(define %system-desktop-manifest
  (map specification->package %system-desktop-manifest-list))

