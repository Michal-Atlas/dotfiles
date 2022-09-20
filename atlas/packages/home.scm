(define-module (atlas packages home)
  #:use-module (ice-9 hash-table)
  #:export (%packages-by-host))

(define shell-utils
  '(
    "file"
    "kitty" "fzf"
    "pandoc" "direnv"
    "vim" "zsh" "git" ("git" "send-email") "htop"
    "xclip" "telescope" "agate"

    "bat" "zoxide" "exa"
    #;"tealdeer"
    ))
(define toolchains
  '(
    "gdb" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"
    "sbcl" "chicken" "racket"
    "gnupg" "swi-prolog"
    ))

(define multimedia
  '(
    "grim" "vlc" "mpv"
    "libreoffice"
    "audacity"
    ))

(define graphics
  '(
    "feh" "shotwell"
    "inkscape" "gimp" "krita"
    "font-fira-code" "font-jetbrains-mono"
    "font-awesome" "font-tamzen"
    "font-sil-charis" "font-adobe-source-han-sans"
    "font-wqy-zenhei" "font-wqy-microhei"
    "gparted"
    "xrandr" "arandr"
    ; "texlive"
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
    "gzdoom" "tintin++" "taisei" "kobodeluxe" ; "dwarf-fortress"

    ))
(define e-mail
  '(
    "mu" "isync" "pinentry"
    ))
(define emacs+xyz
  (map (λ (p) (string-append "emacs-" p))
       '(
	 "tldr"
	 "ediprolog"
	 "next"
	 "use-package"
	 "ac-geiser"
	 "ace-window"
	 "adaptive-wrap"
	 "adaptive-wrap"
	 "aggressive-indent"
	 "all-the-icons"
	 "all-the-icons-dired"
	 "racket-mode"
	 "geiser-racket"
	 "anzu"
	 "rustic"
	 "auctex"
	 "avy"
	 "browse-kill-ring"
	 "haskell-mode"
	 "flycheck-haskell"
	 "calfw"
	 "circe"
	 "company"
	 "company-box"
	 "consult"
	 "crux"
	 "csv"
	 "csv-mode"
	 "dashboard"
	 "debbugs"
	 "direnv"
	 "doom-modeline"
	 "elfeed"
	 "elpher"
	 "embark"
	 "ement"
	 "emms"
	 "esh-autosuggest"
	 "eshell-prompt-extras"
	 "eshell-syntax-highlighting"
	 "eshell-z"
	 "flycheck"
	 "frames-only-mode"
	 "gdscript-mode"
	 "geiser-racket"
	 "git-gutter"
	 "guix"
	 "hackles"
	 "helpful"
	 "highlight-indent-guides"
	 "highlight-indentation"
	 "iedit"
	 "irony-eldoc"
	 "irony-mode"
	 "lsp-mode"
	 "lsp-ui"
	 "magit"
	 "magit-todos"
	 "marginalia"
	 "monokai-theme"
	 "multi-term"
	 "multiple-cursors"
	 "nix-mode"
	 "notmuch"
	 "on-screen"
	 "orderless"
	 "org-fragtog"
	 "org-modern"
	 "org-present"
	 "org-roam"
	 "org-superstar"
	 "ox-gemini"
	 #;"gemini-mode"
	 "paredit"
	 "parinfer-mode"
	 "pdf-tools"
	 "pg"
	 "projectile"
	 "racket-mode"
	 "rainbow-delimiters"
	 "rainbow-identifiers"
	 "realgud"
	 "slime"
	 "solaire-mode"
	 "swiper"
	 "tldr"
	 "undo-tree"
	 "vertico"
	 "vterm"
	 "which-key"
	 "xkcd"
	 "yaml-mode"
	 "yasnippet"
	 "yasnippet-snippets"
	 "zerodark-theme"
	 )))
(define desktop
  '(
    "blueman" "pasystray" "xss-lock"
    "bemenu" "sway" "swayidle" "swaybg" "swayhide"
    "wl-clipboard" "lagrange"
    "grim" "slurp" "foot"
    "nautilus" "gvfs" "youtube-dl" "okular" "pulseaudio"
    "wob" "font-iosevka"
    ))
(define big-games
  '(
    #;"the-dark-mod" "falltergeist"
    "gnushogi" "nethack" "retux" "angband"
    "crawl" "crawl-tiles" "retroarch" "7kaa"
    "marble-marcher" "arx-libertatis"
    ))

(define %packages-by-host
  (alist->hash-table
   `(("dagon" . ,(append shell-utils toolchains multimedia graphics e-mail emacs+xyz desktop))
     ("hydra" . ,(append shell-utils toolchains multimedia graphics e-mail emacs+xyz desktop)))))
