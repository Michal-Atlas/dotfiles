(define-module (atlas packages home)
  #:use-module (ice-9 hash-table)
  #:export (%packages-by-host))

(define shell-utils
  '(
    "file"
    "kitty" "fzf"
    "pandoc" "direnv"
    "vim" "zsh" "git" "htop"
    "xclip"

    "bat" "zoxide" "exa"
    "tealdeer"
    ))
(define toolchains
  '(
    "gcc-toolchain" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"

    "gnupg"
    
    ))
(define multimedia
  '(
    "icedove"
    "grim" "vlc" "mpv"
    "libreoffice"
    "audacity"
    ))
(define graphics
  '(
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

    ))
(define games
  '(
    "lgogdownloader"
    "supertuxkart" "cataclysm-dda"
    "wesnoth" "steam" "sky" "lure"
    "endless-sky" "naev"
    "gzdoom" "tintin++" "taisei" "kobodeluxe" "dwarf-fortress"

    ))
(define e-mail
  '(
    "mu" "isync" "pinentry"
    ))
(define emacs+xyz
  '(
    "emacs-next"
    
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
    "emacs-pg" "emacs-browse-kill-ring"
    "emacs-yaml-mode" "emacs-multi-term"
    "emacs-hackles" "emacs-xkcd"
    
    ))
(define desktop/gnome
  '(
    "gnome-shell-extension-topicons-redux"
    "gnome-shell-extension-paperwm"
    "gnome-shell-extension-gsconnect"
    "gnome-shell-extension-clipboard-indicator"
    "gnome-shell-extension-appindicator" 
    ))
(define desktop
  '(
    "transmission" "stow" "quaternion"
    "i3-wm" "i3status" "i3lock" "i3lock-fancy"
    "nautilus" "okular"
    ))
(define libs
  '(
    "artanis"
    ))
(define big-games
  '(
    "the-dark-mod" "falltergeist"
    "gnushogi" "nethack" "retux" "angband"
    "crawl" "crawl-tiles" "retroarch" "7kaa"
    "marble-marcher" "arx-libertatis"
    ))
(define zsh-plugins
  '(
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "gcr"
    "zsh-common-aliases"
    "zsh-extract"
    "zsh-git-auto-fetch"
    "zsh-shrink-path"
    "zsh-ssh-agent"
    "zsh-dirhistory"
    "zsh-screen"
    "zsh-colored-man-pages"
    "zsh-emacs"
    "zsh-guix"
    "zsh-alias-tips"
    "zsh-theme-geometry"
    ))

(define %packages-by-host
  (alist->hash-table
   `(("Dagon" . ,(append shell-utils zsh-plugins toolchains multimedia graphics games e-mail emacs+xyz desktop libs))
     ("Hydra" . ,(append shell-utils zsh-plugins toolchains multimedia graphics games e-mail emacs+xyz desktop libs big-games)))))
