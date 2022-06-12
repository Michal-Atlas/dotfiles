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
    "gdb" "clang-toolchain" "rust"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"
    "sbcl" "chicken"
    "gnupg"
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
    "gzdoom" "tintin++" "taisei" "kobodeluxe" "dwarf-fortress"

    ))
(define e-mail
  '(
    "mu" "isync" "pinentry"
    ))
(define emacs+xyz
  (map (λ (p) (string-append "emacs-" p))
       '(
	 "next"
	 "use-package"
	 "ac-geiser"
	 "adaptive-wrap"
	 "aggressive-indent"
	 "all-the-icons"
	 "all-the-icons-dired"
	 "anzu"
	 "auctex"
	 "avy"
	 "browse-kill-ring"
	 "calfw"
	 "circe"
	 "company"
	 "company-box"
	 #;"consult"
	 "crux"
	 "dashboard"
	 "direnv"
	 "doom-modeline"
	 "elfeed"
	 "elpher"
	 #;"embark"
	 "ement"
	 "emms"
	 "equake"
	 "esh-autosuggest"
	 "eshell-prompt-extras"
	 "eshell-syntax-highlighting"
	 "eshell-z"
	 "flycheck"
	 "frames-only-mode"
	 "gdscript-mode"
	 "git-gutter"
	 "gruvbox-theme"
	 "guix"
	 "helpful"
	 "highlight-indent-guides"
	 "iedit"
	 "irony-eldoc"
	 "irony-mode"
	 "kana"
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
	 "org-superstar"
	 "paredit"
	 "pdf-tools"
	 "pg"
	 "projectile"
	 "rainbow-delimiters"
	 "rainbow-identifiers"
	 "realgud"
	 "slime"
	 "solaire-mode"
	 "tldr"
	 "undo-tree"
	 "vertico"
	 "vterm"
	 "which-key"
	 "yaml-mode"
	 "yasnippet"
	 "yasnippet-snippets"
	 "zerodark-theme"
	 #;"hackles"
	 #;"xkcd"
	 )))
(define desktop
  '(
    "bemenu" "sway" "swayidle" "swaybg" "swayhide"
    "wl-clipboard"
    "grim" "slurp" "foot"
    "nautilus" "okular"
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
   `(("dagon" . ,(append shell-utils toolchains multimedia graphics e-mail emacs+xyz desktop))
     ("hydra" . ,(append shell-utils toolchains multimedia graphics games e-mail emacs+xyz desktop big-games)))))
