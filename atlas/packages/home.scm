(define-module (atlas packages home)
  #:use-module (gnu packages)
  #:export (%home-desktop-manifest))

(define %home-desktop-manifest-list
  `(
    ;; Emacs
    "emacs-next"
    
    ;; Shell utils
    "file"
    "kitty" "fzf"
    "pandoc" "direnv"
    "vim" "zsh" "git" "htop"
    "xclip"
    
    ;; Toolchains
    "gcc-toolchain" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"

    "gnupg"
    
    ;; Shell utils
    "bat" "zoxide" "exa"
    "tealdeer"

    ;; Multimedia
    "wine"
    "icedove"
    "grim" "vlc" "mpv"
    "libreoffice"
    "audacity"

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

    ;; Games
    "devilutionx"
    "lgogdownloader" "the-dark-mod"
    "supertuxkart" "cataclysm-dda" "falltergeist"
    "gnushogi" "nethack" "retux" "angband" "crawl" "crawl-tiles"
    "wesnoth" "steam" "retroarch" "7kaa" "sky" "lure"
    "marble-marcher" "arx-libertatis" "endless-sky" "naev"
    "gzdoom" "tintin++" "taisei" "kobodeluxe" "dwarf-fortress"

    ;; Email
    "mu" "isync"

    ;; Emacs
    "emacs-all-the-icons" "emacs-auctex"
    "emacs-dashboard" "emacs-highlight-indent-guides"
    "emacs-doom-modeline"
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
    "emacs-notmuch" "notmuch"
    "emacs-tldr" "emacs-direnv"
    "emacs-kana" "emacs-circe"
    "emacs-vterm" "emacs-nix-mode"
    "emacs-monokai-theme" "emacs-ement"
    "emacs-pg"
    
    ;; DE/Gnome
    "gnome-shell-extension-topicons-redux"
    "gnome-shell-extension-paperwm"
    "gnome-shell-extension-gsconnect"
    "gnome-shell-extension-clipboard-indicator"
    "gnome-shell-extension-appindicator" 

    ;; DE
    "transmission" "stow" "quaternion"
    "i3-wm" "i3status" "i3lock" "i3lock-fancy"
    "nautilus" "okular"
    ))

(define %home-desktop-manifest
  (map specification->package %home-desktop-manifest-list))
