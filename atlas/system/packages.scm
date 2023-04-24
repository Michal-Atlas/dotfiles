(define-module (atlas system packages)
  #:use-module (gnu packages)
  #:export (%system-desktop-manifest))

(define (pkg-set name pkgs)
  (map (lambda (q) (string-append name "-" q)) pkgs))

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

    ;; KAB
    "pkg-config" "openssl" "indent"

    ;; Gnome extensions
    "gnome-shell-extensions"
    "gnome-shell-extension-clipboard-indicator"
    "gnome-shell-extension-paperwm"
    "gnome-shell-extension-appindicator"
    "gnome-shell-extension-sound-output-device-chooser"
    
    ;; Emacs
    "emacs"
    ,@(pkg-set
       "emacs"
       `(; "exwm"
         "org-roam"
	     "org-roam-ui"
	     "consult-org-roam"
                                        ;	  "org-roam-timestamps"
	     "engrave-faces"
	     "go-mode"
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
	     "sly"
	     "slime"
	     "geiser"
	     "multiple-cursors"
	     "magit"
	     "helpful"
	     "avy"
	     "browse-kill-ring"
	     "emms"
	     "evil"
	     "vertico"
	     "vertico-posframe"
	     "orderless"
	     "consult"
	     "xah-fly-keys"
	     "ac-geiser"
	     "all-the-icons"
	     "all-the-icons-dired"
	     "auctex"
	     "calfw"
	     "cheat-sh"
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
	     "elisp-autofmt"
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
	     "lispy"
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
	     "stumpwm-mode"
	     "hackles"
	     "yasnippet-snippets"
	     "consult-yasnippet"
	     "yasnippet"
	     "tramp"
	     "ssh-agency"
	     "password-generator"
	     "mastodon"
	     "stumpwm-mode"))

    "yt-dlp"
    
    ;; Libs
    "ncurses" "curl" "virt-manager"
    "ntfs-3g" "btrfs-progs"
    "cifs-utils"

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
    "nss-certs" "xdg-utils"

    "sway"
    "sbcl"
    "stumpwm"
    "buildapp"
    "stumpish"
    ,@(pkg-set
       "sbcl"
       `( ;; StumpWM
            ,@(pkg-set
               "stumpwm"
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
            "linedit" "mcclim"
            "serapeum" "eclector"
            "alexandria" "cl-yacc"
            "cl-autowrap" "optima" "lparallel"
            "coalton" "coleslaw" "parser-combinators"
            "collectors" "cl-strings"
            "unix-opts" "cffi" "series"
            "trial" "trees" "sycamore"
            "terminfo" "terminal-size"
            "terminal-keypress" "tar"
            "tailrec" "screamer" "s-xml"))))

(define %system-desktop-manifest
  (map specification->package %system-desktop-manifest-list))

