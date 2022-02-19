(define-module (atlas packages system)
  #:use-module (gnu packages)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages gcc)
  #:export (%system-desktop-manifest))

(define %system-desktop-manifest-list
  `(
    "nvi"
    
    ;; DE
    "xnotify" "brightnessctl" "pamixer" "playerctl"
    "firefox" "xscreensaver" "gparted"
    "pavucontrol" "screen"
    
    ;; Emacs
    "emacs-next"
    "emacs-exwm"
    
    ;; Libs
    "ncurses" "curl" "virt-manager"
    "ntfs-3g" "btrfs-progs" ;; "artanis"

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
  (cons
   (list clang-13 "extra")
   (map specification->package %system-desktop-manifest-list)))

