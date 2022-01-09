(define-module (atlas home manifests)
  #:use-module (gnu packages)
  #:use-module (nongnu packages mozilla)
  #:export (%home-desktop-manifest))

(define %home-desktop-manifest-list
  `(
    ;; DE
    "xnotify" "brightnessctl" "pamixer" "playerctl"
    "firefox" "qutebrowser"
    "i3-wm" "i3status" "i3lock" "i3lock-fancy"
    "nautilus" "okular"
    "pavucontrol"
    "transmission" "stow"

    ;; DE/Gnome
    "gnome-shell-extension-topicons-redux"
    "gnome-shell-extension-paperwm"
    "gnome-shell-extension-gsconnect"
    "gnome-shell-extension-clipboard-indicator"
    "gnome-shell-extension-appindicator"
    
    ;; Emacs
    "emacs-next"
    "emacs-exwm"
    "emacs-all-the-icons"
    "emacs-dashboard" "emacs-highlight-indent-guides"
    "emacs-spacemacs-theme" "emacs-doom-modeline"
    "emacs-solaire-mode"
    "emacs-which-key"
    "emacs-company" "emacs-company-box"
    "emacs-rainbow-delimiters" "emacs-rainbow-identifiers"
    "emacs-helpful"
    "emacs-aggressive-indent"
    "emacs-crux" "emacs-undo-tree"
    "emacs-flycheck" "emacs-yasnippet"
    "emacs-projectile" "emacs-vertico"
    "emacs-orderless"
    "emacs-lsp-ui" "emacs-lsp-mode"
    "emacs-magit" "emacs-magit-todos"
    "emacs-guix" "emacs-adaptive-wrap"
    "emacs-calfw" "emacs-pdf-tools"
    "emacs-all-the-icons-dired" "emacs-git-gutter"
    "emacs-org-fragtog" "emacs-avy"
    "emacs-anzu" "emacs-org-present" "emacs-org-superstar"
    "emacs-marginalia" "emacs-embark"
    "emacs-consult"
    "emacs-irony-mode" "emacs-irony-eldoc"
    "emacs-elfeed" "emacs-frames-only-mode"
    "emacs-ac-geiser" "emacs-paredit" "emacs-iedit"
    "emacs-multiple-cursors"
    "emacs-gruvbox-theme"
    "emacs-on-screen"

    ;; Email
    "mu" "isync" "gnupg" "pinentry"

    ;; Games
    "devilutionx"
    "lgogdownloader" "the-dark-mod"
    "supertuxkart" "cataclysm-dda" "falltergeist"
    "gnushogi" "nethack" "retux" "angband"
    "wesnoth" "steam" "retroarch" "7kaa" "sky" "lure"
    "marble-marcher" "arx-libertatis" "endless-sky" "naev"
    "gzdoom" "tintin++" "taisei" "kobodeluxe"

    ;; Graphics
    "feh" "shotwell"
    "inkscape" "gimp" "blender" "kdenlive" "krita"
    "font-fira-code" "font-jetbrains-mono"
    "font-awesome" "font-tamzen"
    "font-sil-charis" "font-adobe-source-han-sans"
    "font-wqy-zenhei" "font-wqy-microhei"
    "gparted" "keepassxc"
    "xrandr" "arandr"
    "texlive"
    "graphviz" "xdot"
    "xdotool" "tree"
    "bc" "unzip"

    ;; Multimedia
    "wine64"
    "icedove"
    "grim" "vlc"
    "libreoffice"
    "audacity"
    
    ;; Libs
    "ncurses" "curl" "virt-manager"

    ;; Shell utils
    "dmenu" "rofi" "file"
    "alacritty" "st" "bat" "zoxide" "exa" "fzf"
    "pandoc" "tealdeer" "tmux"
    "vim" "zsh" "git" "htop"
    
    ;; Toolchains
    "gcc-toolchain" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh" "luajit" "perl" "nix"
    
    "nss-certs" "xdg-utils"))

(define %home-desktop-manifest
  (map specification->package %home-desktop-manifest-list))

(specifications->manifest %home-desktop-manifest-list)
