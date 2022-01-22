(define-module (atlas packages system)
  #:use-module (gnu packages)
  #:use-module (gnu packages llvm)
  #:export (%system-desktop-manifest))

(define %system-desktop-manifest-list
  `(
    ;; DE
    "xnotify" "brightnessctl" "pamixer" "playerctl"
    "firefox"
    "pavucontrol" "screen"
    
    ;; Emacs
    "emacs-next"
    "emacs-exwm"
    
    ;; Libs
    "ncurses" "curl" "virt-manager"
    "ntfs-3g"

    ;; Shell utils
    "file"
    "kitty" "fzf"
    "pandoc"
    "vim" "zsh" "git" "htop"
    
    ;; Toolchains
    "gcc-toolchain" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh" "luajit" "perl" "nix"

    "openvpn" "network-manager-openvpn"
    "gnupg" "pinentry"    
    "nss-certs" "xdg-utils"))

(define %system-desktop-manifest
  (cons (list clang-13 "extra") (map specification->package %system-desktop-manifest-list)))

