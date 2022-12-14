(define-module (atlas home packages)
  #:use-module (ice-9 hash-table))

(define shell-utils
  '(
    "file"
    "kitty" "fzf"
    "pandoc" "direnv"
    "vim" "zsh" "git" ("git" "send-email") "htop"
    "xclip" "telescope" "agate"
    "fasd"
    "bat" "zoxide" "exa"
					;"tealdeer"
    "password-store"
    "pass-otp"
    "guile-filesystem"
    ))
(define toolchains
  '(
    "gdb" "clang-toolchain" "rust" "ccls"
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
    "inkscape" "gimp" ; "krita"
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
  (cons "emacs"
   (map (lambda (q) (string-append "emacs-" q))
	`(
	  "use-package"
	  "password-store"
	  "password-store-otp"
	  "org-fragtog"
	  "org-modern"
	  "org-superstar"
	  "highlight-indentation"
					;"mode-icons"
	  "doom-modeline"
	  "which-key"
	  "rainbow-identifiers"
	  "rainbow-delimiters"
	  "undo-tree"
	  "ace-window"
	  "eshell-prompt-extras"
	  "eshell-syntax-highlighting"
	  "esh-autosuggest"
	  "git-gutter"
					;"savehist"
	  "anzu"
	  "marginalia"
					;"org-roam"
					;"org-roam-ui"
	  "auto-complete"
	  "geiser-racket"
	  "adaptive-wrap"
	  "geiser-guile"
	  "slime"
	  "geiser"
	  "multiple-cursors"
	  "magit"
	  "helpful"
	  "avy"
	  "browse-kill-ring"
	  "emms"
	  "evil"
	  "exwm"
	  "vertico"
	  "orderless"
	  "consult"
	  "xah-fly-keys"
	  "ac-geiser"
	  "all-the-icons"
	  "all-the-icons-dired"
	  "auctex"
	  "calfw"
	  "circe"
	  "company"
	  "company-box"
	  "crux"
	  "csv"
	  "csv-mode"
	  "dashboard"
	  "debbugs"
	  "direnv"
	  "ediprolog"
	  "elfeed"
	  "elpher"
	  "embark"
	  "ement"
	  "lsp-mode"
	  "lsp-ui"
	  "rustic"
	  "eshell-z"
	  "flycheck"
	  "flycheck-haskell"
	  "frames-only-mode"
	  "gdscript-mode"
	  "guix"
	  "haskell-mode"
	  "highlight-indent-guides"
	  "htmlize"
	  "iedit"
	  "magit-todos"
	  "monokai-theme"
	  "multi-term"
	  "nix-mode"
	  "on-screen"
	  "ox-gemini"
					;"parinfer"
	  "pdf-tools"
	  "pg"
	  "projectile"
	  "racket-mode"
	  "realgud"
	  "swiper"
	  "tldr"
	  "vterm"
	  "xkcd"
	  "yaml-mode"
	  "yasnippet"
	  "yasnippet-snippets"
	  "zerodark-theme"
	  "gemini-mode"
					;"nov"
	  "dockerfile-mode"
	  "docker"
	  "dmenu"
	  "eglot"
	  "org"
	  "hackles"
	  "yasnippet-snippets"
	  "consult-yasnippet"
	  "yasnippet"
	  "tramp"
	  "ssh-agency"
	  "password-generator"
	  ))))
(define desktop
  '(
    "i3-autotiling"
    "blueman" "pasystray" "xss-lock"
    "bemenu" "sway" "swayidle" "swaybg" "swayhide"
    "wl-clipboard" "lagrange"
    "grim" "slurp" "foot"
    "nautilus" "gvfs" "youtube-dl" "okular" "pulseaudio"
    "wob" "font-iosevka" "browserpass-native"
    ))
(define big-games
  '(
    #;"the-dark-mod" "falltergeist"
    "gnushogi" "nethack" "retux" "angband"
    "crawl" "crawl-tiles" "retroarch" "7kaa"
    "marble-marcher" "arx-libertatis"
    ))

(define-public %packages-by-host
  (alist->hash-table
   `(("dagon" . ,(append shell-utils toolchains multimedia graphics e-mail emacs+xyz desktop))
     ("hydra" . ,(append shell-utils toolchains multimedia graphics e-mail emacs+xyz desktop)))))
