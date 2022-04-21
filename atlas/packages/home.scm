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
    "gcc-toolchain" "gdb" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"
    "sbcl"
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
    "inkscape" "gimp" "blender" "krita"
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
    "emacs-slime"
    "emacs-all-the-icons" "emacs-auctex"
    "emacs-dashboard" "emacs-highlight-indent-guides"
    "emacs-solaire-mode"
    "emacs-which-key"
    "emacs-company" "emacs-company-box"
    "emacs-rainbow-delimiters" "emacs-rainbow-identifiers"
    "emacs-helpful"
    "emacs-aggressive-indent"
    "emacs-crux" "emacs-undo-tree"
    "emacs-flycheck"
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
    "emacs-consult" "emacs-elpher"
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
    "emacs-realgud"
    "emacs-gdscript-mode"
    "emacs-emms"
    "emacs-eshell-z"
    ;; "emacs-equake"
    "emacs-eshell-syntax-highlighting"
    "emacs-eshell-prompt-extras"
    ;; "emacs-esh-autosuggest"
    ))
(define desktop
  '(
    "transmission" "stow" "quaternion"
    "bemenu" "sway" "swayidle" "swaybg" "swayhide"
    "wdisplays" "wl-clipboard"
    "grim" "slurp"
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

(define %packages-by-host
  (alist->hash-table
   `(("Dagon" . ,(append shell-utils toolchains multimedia graphics games e-mail emacs+xyz desktop libs))
     ("Hydra" . ,(append shell-utils toolchains multimedia graphics games e-mail emacs+xyz desktop libs big-games)))))
