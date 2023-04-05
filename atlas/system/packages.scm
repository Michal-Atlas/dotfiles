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
    ;;"sway"
    "i3status" "i3lock"
    "flatpak" "font-fira-code"
    "breeze-icons" "hicolor-icon-theme"
    "adwaita-icon-theme"

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
    "nss-certs" "xdg-utils"

    "sbcl"
    "stumpwm"
    "buildapp"
    "stumpish"
    ,@(map (lambda (q) (string-append "sbcl-" q))
           `( ;; StumpWM
             ,@(map (lambda (q) (string-append "stumpwm-" q))
                    `("winner-mode"
                      "swm-gaps"
                      "screenshot"
                      "pass"
                      "pamixer"
                      "numpad-layouts"
                      "notify"
                      "kbd-layouts"
                      "disk"
                      "battery-portable"
                      "globalwindows"
                      "wifi"
                      "ttf-fonts"
                      "stumptray"
                      "net"
                      "mem"
                      "cpu"))

             "linedit"
             "serapeum"
             "alexandria"
             "cl-autowrap" "optima"
             "coalton" "coleslaw"
             "collectors" "cl-strings"
             "unix-opts" "cffi" "series"
             "trial" "trees" "sycamore"
             "terminfo" "terminal-size"
             "terminal-keypress" "tar"
             "tailrec" "screamer" "s-xml"
             ))))

(define %system-desktop-manifest
  (map specification->package %system-desktop-manifest-list))

