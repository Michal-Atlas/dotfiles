(use-modules
 (gnu home)
 (gnu home services)
 (gnu home services shells)
 (gnu home services shepherd)
 (gnu home services ssh)
 (gnu home services fontutils)
 (gnu home services guix)
 (gnu home services desktop)
 (gnu services)
 (gnu packages)
 (gnu packages admin)
 (gnu packages emacs)
 (gnu packages password-utils)
 (gnu packages wm)
 (gnu packages xdisorg)
 (gnu packages python-xyz)
 (gnu packages freedesktop)
 (gnu packages shellutils)
 (gnu services xorg)
 (gnu packages mpd)
 (gnu packages lisp)
 (gnu packages curl)
 (gnu home services mcron)
 (ice-9 hash-table)
 (gnu system keyboard)
 (guix gexp)
 (guix base64)
 (guix download)
 (guix channels)
 (guix modules)
 (guix monads)
 (guix store)
 (guix derivations)
 (ice-9 match)
 (gnu packages gnome)
 (guix packages)
 (guix build-system copy)
 (guix download)
 (gnu services configuration)
 (gnu packages package-management)
 (guix records))


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
    "transmission-remote-gtk"
    "transmission"
    "pkg-config"
    ))
(define toolchains
  '(
    "gdb" "clang-toolchain" "go" "ccls"
    "cmake" "make" "recutils" "python" "python-ipython"
    "mosh"
    "sbcl" "chicken" "racket"
    "gnupg" "swi-prolog"
    "sbcl-linedit"
    ))

(define multimedia
  '(
    "grim" "vlc" "mpv"
    "libreoffice"
    "audacity"
    "yt-dlp" "picard"
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
    "graphviz" "xdot"
    "xdotool" "tree"
    "bc" "unzip"
    ))
(define latex
  '("texlive"
    "texlive-tcolorbox"))
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
	`("org-roam"
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
	  "stumpwm-mode"
	  "hackles"
	  "yasnippet-snippets"
	  "consult-yasnippet"
	  "yasnippet"
	  "tramp"
	  "ssh-agency"
	  "password-generator"
	  "mastodon"
	  "stumpwm-mode"
	  ))))
(define desktop
  '("fontconfig" "font-ghostscript" "font-dejavu" "font-gnu-freefont"
    "font-adobe-source-han-sans" "font-wqy-zenhei"
    "guix-icons" "breeze-icons" "oxygen-icons"
    "i3-autotiling"
    "blueman" "pasystray" "xss-lock"
    "bemenu" "sway" "swayidle" "swaybg" "swayhide"
    "wl-clipboard" "lagrange"
    "grim" "slurp" "foot"
    "nautilus" "gvfs" "youtube-dl" "okular" "pulseaudio"
    "wob" "font-iosevka" "browserpass-native"
    "xsetroot"
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

(define (file-fetch url hash)
  (file-append
   (package
     (name "file-fetch")
     (version "1")
     (source
      (origin
	(method url-fetch)
	(uri url)
	(file-name "file")
	(sha256 (base64 hash))))
     (build-system copy-build-system)
     (description "")
     (synopsis "")
     (home-page url)
     (license #f))
   "/file"))

(define (alist-value-print value)
  (define (list-vals lv) (string-join (map alist-value-print lv) ", "))
  (match value
    [#t "true"]
    [#f "false"]
    [(? string? str) (format #f "'~a'" str)]
    [(entries ...)
     (format #f "(~a)" (list-vals entries))]
    [#(entries ...)
     (format #f "[~a]" (list-vals entries))]
    [v (format #f "~a" v)]))

(define (alist->ini al)
  (string-concatenate
   (map
    (match-lambda
      [(top-level-path entries ...)
       (format #f "[~a]~%~a~%" top-level-path
               (string-concatenate
                (map
                 (match-lambda
                   [(var value)
                    (format #f "~a=~a~%" var
                            (alist-value-print value))])
                 entries)))])
    al)))


(define (dconf-load-gexp settings)
  #~(begin
       (use-modules (ice-9 popen))
       (let ([dc-pipe (open-pipe* OPEN_WRITE #$(file-append dconf "/bin/dconf") "load" "/")])
         (display #$(alist->ini settings) dc-pipe))))

(define dconf-load-service-type
  (service-type (name 'dconf-load-service)
                (extensions
                 (list
                  (service-extension
                   home-activation-service-type
                   dconf-load-gexp)))
                (default-value '())
                (description "Loads an Alist of INI Dconf entries on activation")))

(define (nix-profile-gexp configuration)
  #~ (primitive-load #$ (nix-profile configuration)))

(define (nix-profile configuration)
  (program-file
   "nix-profile-setup"
   #~ (begin
        (let ([profile-file "/home/michal_atlas/.nix-profile"])
          (invoke "nix"
                  "profile" "remove" ".*"
                  "--extra-experimental-features" "nix-command flakes"
                  "--profile" profile-file "--impure")
          (setenv "NIXPKGS_ALLOW_UNFREE" "1")
          (invoke "nix"
                  "profile" "install"
                  "--extra-experimental-features" "nix-command flakes"
                  "--impure" "--profile" profile-file
                  #$@configuration)))))

(define nix-profile-service-type
  (service-type (name 'nix-profile-service)
                (extensions
                 (list
                  (service-extension
                   home-activation-service-type
                   nix-profile-gexp)))
                (default-value #f)
                (description "")))

(home-environment
 (packages
  (map (λ (f)
	     (if (list? f)
	         (apply specification->package+output f)
	         (specification->package f)))
       (hash-ref %packages-by-host (vector-ref (uname) 1))))
 (services
  (list
   (service dconf-load-service-type
            `((org/gnome/shell
               (disable-user-extensions #f)
               (enabled-extensions
                #("launch-new-instance@gnome-shell-extensions.gcampax.github.com"
                  "drive-menu@gnome-shell-extensions.gcampax.github.com"
                  "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
                  "appindicatorsupport@rgcjonas.gmail.com"
                  "nightthemeswitcher@romainvigier.fr"
                  "gnome-extension-all-ip-addresses@havekes.eu"
                  "color-picker@tuberry"
                  "espresso@coadmunkee.github.com"
                  "gnome-clipboard@b00f.github.io")))
              (org/gnome/desktop/peripherals/touchpad
               (tap-to-click #t))
              (org/gnome/settings-daemon/plugins/media-keys
               (custom-keybindings
                #("/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/")))
              (org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0
               (binding "<Super>t")
               (command "emacsclient -c -e \\'(eshell-new)\\'")
               (name "TERM"))

              (org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1
               (binding "<Super>Return")
               (command "emacsclient -c")
               (name "EMACS"))

	      (org/gnome/desktop/background
               (picture-uri "/home/michal_atlas/.light-wallpaper.png")
               (picture-uri-dark "/home/michal_atlas/.dark-wallpaper.png"))

              (org/gnome/desktop/input-sources
               (sources #(("xkb" "us") ("xkb" "cz+ucw")))
               (xkb-options #("grp:caps_switch" "lv3:ralt_switch"
			      "compose:rctrl-altgr")))

              (org/gnome/system/location
               (enabled #t))

              (org/gnome/shell/extensions/nightthemeswitcher/time
               (manual-schedule #f))

              (org/gnome/desktop/wm/preferences
               (focus-mode "sloppy"))

              (org/gnome/settings-daemon/plugins/color
               (night-light-enabled #t))))
   
   (service home-shepherd-service-type
	    (home-shepherd-configuration
	     (services
	      (list
	       (shepherd-service
		(provision '(disk-automount))
		(start #~(make-forkexec-constructor
			  (list #$(file-append udiskie "/bin/udiskie"))))
		(stop #~(make-kill-destructor)))
	       (shepherd-service
		(provision '(emacs))
		(start #~(make-forkexec-constructor
			  (list #$(file-append emacs "/bin/emacs") "--fg-daemon")
			  #:environment-variables
			  (cons*
			   "GDK_SCALE=2"
			   "GDK_DPI_SCALE=0.41"
			   (default-environment-variables))))
		(stop #~(make-system-destructor
			 "emacsclient -e '(save-buffers-kill-emacs)'")))))))
   (service
    home-mcron-service-type
    (home-mcron-configuration
     (jobs
      (list
       #~(job '(next-minute '(0))
	      (string-append 
	       #$(file-append sbcl "/bin/sbcl")
	       " --script "
	       #$(local-file "files/old-move-script.lisp")))
       #~(job "30 01 * * 0"
	      (string-append
	       "guix time-machine -C "
	       #$(local-file "channels.scm")
	       " home reconfigure "
	       #$(local-file "home.scm")))))))
   (simple-service
    'dotfiles
    home-files-service-type
    `(
      (".dark-wallpaper.png"
       ,(file-fetch "https://images.alphacoders.com/923/923968.jpg"
		    "DIbte8/pJ2/UkLuojowdueXT5XYz2bns3pIyELXiCnw="))
      (".light-wallpaper.png"
       ,(file-fetch "https://ift.tt/2UDuBqa"
		    "i7XCgxwaBYKB7RkpB2nYcGsk2XafNUPcV9921oicRdo="))
      (".emacs.d/init.el" ,(local-file "files/emacs.el"))
      (".guile" ,(local-file "files/guile"))
      ;; (".screenrc" ,(local-file "../screen"))
      ;; (".mbsyncrc" ,(local-file "../mbsyncrc"))
      (".sbclrc" ,(local-file "files/sbclrc"))
      (".stumpwm.d/init.lisp" ,(local-file "files/stumpwm.lisp"))))
   (simple-service
    'dotfiles-xdg
    home-xdg-configuration-files-service-type
    `(
      ("common-lisp/source-registry.conf" ,(local-file "files/asdf.lisp"))
      ;; ("sway/config" ,(local-file "../sway.cfg"))
      ("foot/foot.ini" ,(local-file "files/foot.ini"))
      ))
                                        ;(".emacs.d/eshell/alias" ,(local-file "../eshell-alias"))
   #;
   (service nix-profile-service-type	;
   (map (lambda (pkg) (string-append "nixpkgs#" pkg)) ;
   (list "sage"				;
   "zotero" "acl2-minimal" "discord"	;
   "dotnet-sdk" "vscode")))
   #;
   (service home-redshift-service-type)
   
   (service
    home-bash-service-type
    (home-bash-configuration
     (guix-defaults? #t)
     (bashrc
      (list
       (mixed-text-file "bashrc-direnv"
		   "eval \"$("
		   (file-append direnv "/bin/direnv")
		   " hook bash)\"")
       (plain-file "bashrc-ignoredups" "export HISTCONTROL=ignoredups")
       (mixed-text-file "bashrc-run"
			"function run { "
			(file-append guix "/bin/guix")
			" shell $1 -- $@; }")
       (mixed-text-file "bashrc-valgrind"
		   "alias valgrind=\""
		   (file-append guix "/bin/guix")
		   " shell -CF valgrind -- valgrind \"")
       (mixed-text-file "bashrc-fasd" "eval \"$("
		   (file-append fasd "/bin/fasd")
		   " --init auto)\"")
       (mixed-text-file "bashrc-cheat"
			"function cheat { "
			(file-append curl "/bin/curl")
			" \"cheat.sh/$@\"; }")))
     (aliases
      `(("gx" . "guix")
	("gxi" . "gx install")
	("gxb" . "gx build")
	("gxs" . "gx search")
	("gxsh" . "gx shell")
	("gxtm" . "gx time-machine")
	("e" . "$EDITOR")
	("es" . "$EDITOR -nw -e '(eshell-new)'")
	("sw" . "swayhide")))
     (environment-variables
      `(
	("BROWSER" . "firefox")
	("EDITOR" . "emacsclient -n -c")
	("TERM" . "xterm-256color")
	("MOZ_ENABLE_WAYLAND" . "1")
	("MOZ_USE_XINPUT2" . "1")
	("GRIM_DEFAULT_DIR" . "~/tmp")
	("_JAVA_AWT_WM_NONREPARENTING" . "1")
	("PATH" . "$PATH:$HOME/.nix-profile/bin/")
	("PATH" . "$PATH:$HOME/bin/")
	("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
	("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/dotfiles")
	("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/michal_atlas/.local/share/flatpak/exports/share")))))
   (service home-channels-service-type
	    (cons*
	     (channel
	      (name 'nonguix)
	      (url "https://gitlab.com/nonguix/nonguix")
	      (branch "master")
	      (introduction
	       (make-channel-introduction
		"897c1a470da759236cc11798f4e0a5f7d4d59fbc"
		(openpgp-fingerprint
		 "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
	     (channel
	      (name 'guixrus)
	      (url "https://git.sr.ht/~whereiseveryone/guixrus")
	      (introduction
	       (make-channel-introduction
		"7c67c3a9f299517bfc4ce8235628657898dd26b2"
		(openpgp-fingerprint
		 "CD2D 5EAA A98C CB37 DA91  D6B0 5F58 1664 7F8B E551"))))
	     (channel
	      (name 'atlas)
	      (url "https://git.sr.ht/~michal_atlas/guix-channel"))
	     (channel
	      (name 'guix-gaming-games)
	      (url "https://gitlab.com/guix-gaming-channels/games.git")
	      (introduction
	       (make-channel-introduction
		"c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
		(openpgp-fingerprint
		 "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
	     #;
	     (channel                   ; ; ; ; ; ; ; ; ; ; ; ; ;
	     (name 'emacs)              ; ; ; ; ; ; ; ; ; ; ; ; ;
	     (url "https://github.com/babariviere/guix-emacs") ; ; ; ; ; ; ; ; ; ; ; ; ;
	     (introduction              ; ; ; ; ; ; ; ; ; ; ; ; ;
	     (make-channel-introduction ; ; ; ; ; ; ; ; ; ; ; ; ;
	     "72ca4ef5b572fea10a4589c37264fa35d4564783" ; ; ; ; ; ; ; ; ; ; ; ; ;
	     (openpgp-fingerprint       ; ; ; ; ; ; ; ; ; ; ; ; ;
	     "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18"))))
	     %default-channels))
   ;; (service home-provenance-service-type)
   (service home-openssh-service-type
	    (home-openssh-configuration
	     (hosts (append
		     (list
		      (openssh-host
		       (name "Myst")
		       (host-name "34.122.2.188"))
		      (openssh-host
		       (name "ZmioSem")
		       (user "michal_zacek")
		       (port 10169)
		       (host-name "hiccup.mazim.cz")))
		     (map (lambda (q)
			    (openssh-host
			     (name (string-append "Fray" q))
			     (host-name (string-append "fray" q ".fit.cvut.cz"))
			     (user "zacekmi2")
			     (host-key-algorithms (list "+ssh-rsa"))
			     (accepted-key-types (list "+ssh-rsa"))
			     (extra-content "  ControlMaster auto")))
			  '("1" "2")))
		    )
	     (authorized-keys (list (local-file "keys/hydra.pub")
				    (local-file "keys/dagon.pub"))))))))
