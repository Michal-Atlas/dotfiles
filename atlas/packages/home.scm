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
  '(
    "emacs-next"
    ))
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
