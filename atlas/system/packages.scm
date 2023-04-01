(define-module (atlas system packages)
  #:use-module (gnu packages)
  #:export (%system-desktop-manifest))

(define %system-desktop-manifest-list
  `(
    "nvi" "patchelf"
    
    ;; DE
    "fontconfig" "font-ghostscript" "font-dejavu" "font-gnu-freefont"
    "font-adobe-source-han-sans" "font-wqy-zenhei"
    "guix-icons" "breeze-icons" "oxygen-icons"
    "xnotify" "brightnessctl" "pamixer" "playerctl"
    "firefox" "xscreensaver" "gparted"
    "nautilus" "gvfs" "samba"
    "pavucontrol" "screen"
    "sway"
    "i3status" "i3lock"
    "flatpak" "font-fira-code"
    "breeze-icons" "hicolor-icon-theme"
    "adwaita-icon-theme"

    ;; StumpWM
     "stumpwm"
     "sbcl-stumpwm-winner-mode"
     "sbcl-stumpwm-swm-gaps"
     "sbcl-stumpwm-screenshot"
     "sbcl-stumpwm-pass"
     "sbcl-stumpwm-pamixer"
     "sbcl-stumpwm-numpad-layouts"
     "sbcl-stumpwm-notify"
     "sbcl-stumpwm-kbd-layouts"
     "sbcl-stumpwm-disk"
     "sbcl-stumpwm-battery-portable"
     "sbcl-stumpwm-globalwindows"
     "sbcl-stumpwm-wifi"
     "sbcl-stumpwm-ttf-fonts"
     "sbcl-stumpwm-stumptray"
     "sbcl-stumpwm-net"
     "sbcl-stumpwm-mem"
     "sbcl-stumpwm-cpu"
     "stumpish"
    
     ;; Emacs
     "emacs"
    #;"emacs-exwm"
    
    ;; Libs
    "ncurses" "curl" "virt-manager"
    "ntfs-3g" "btrfs-progs"
    "cifs-utils"

    ;; Shell utils
    "file" "screen"
    "kitty" "fzf"
    "pandoc" "zutils"
    "vim" "zsh" "git" "htop"

    ;; Gnome extensions
    "gnome-shell-extensions"
    "gnome-shell-extension-clipboard-indicator"
    "gnome-shell-extension-paperwm"
    "gnome-shell-extension-appindicator"
    "gnome-shell-extension-sound-output-device-chooser"
    
    ;; Toolchains
    "gcc-toolchain" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh" "luajit" "perl" "nix"

    "openvpn" "network-manager-openvpn"
    "gnupg" "pinentry"    
    "nss-certs" "xdg-utils"))

(define %system-desktop-manifest
  (map specification->package %system-desktop-manifest-list))

