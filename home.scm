;; Imports

;; [[file:Dotfiles.org::*Imports][Imports:1]]
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
 (gnu packages base)
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
 (guix records)
 (atlas home services dconf)
 (atlas home services git))
;; Imports:1 ends here

;; Custom Services


;; [[file:Dotfiles.org::*Custom Services][Custom Services:1]]
(define (file-fetch url hash)
  (with-store store
    (run-with-store store
     (url-fetch url 'sha256 (base64-decode hash)))))
;; Custom Services:1 ends here

(define profiles
  '("/run/current-system/profile"
    "/home/michal_atlas/.guix-home/profile"
    "/home/michal_atlas/.guix-profile"))

;; Dconf
;; Dconf:1 ends here

;; Home Environment


;; [[file:Dotfiles.org::*Home Environment][Home Environment:1]]
(home-environment
 (services
  (list
   (service home-dconf-load-service-type
	    #~`((org/gnome/shell
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
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
                    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/")))
                (org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0
                 (binding "<Super>t")
                 (command "kgx")
                 (name "TERM"))

                (org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1
                 (binding "<Super>Return")
                 (command "emacsclient -c")
                 (name "EMACS"))

                (org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2
                 (binding "<Super>f")
                 (command "nyxt")
                 (name "BROWSER"))

                (org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3
                 (binding "<Super>e")
                 (command "nautilus")
                 (name "FILES"))

                (org/gnome/desktop/background
                 (picture-uri
                  #$(file-fetch "https://ift.tt/2UDuBqa"
                                "i7XCgxwaBYKB7RkpB2nYcGsk2XafNUPcV9921oicRdo="))
                 (picture-uri-dark
                  #$(file-fetch "https://images.alphacoders.com/923/923968.jpg"
                                "DIbte8/pJ2/UkLuojowdueXT5XYz2bns3pIyELXiCnw=")))

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
                 (night-light-enabled #t))

                (org/gnome/shell
                 (favorite-apps
                  #("firefox.desktop"
                    "spotify.desktop"
                    "discord.desktop"
                    "org.keepassxc.KeePassXC.desktop"
                    "fi.skyjake.Lagrange.desktop"
                    "zotero.desktop"
                    "org.gnome.Nautilus.desktop")))

                (org/gnome/mutter
                 (edge-tiling #t)
                 (dynamic-workspaces #t)
                 (workspaces-only-on-primary #t))

                (org/gnome/shell/app-switcher
                 (current-workspace-only #t))))

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
			         "emacsclient -e '(save-buffers-kill-emacs)'")))
                (shepherd-service
                 (provision '(mpdris))
                 (start #~(make-forkexec-constructor
                           (list #$(file-append mpdris2 "/bin/mpDris2"))))
                 (stop #~(make-kill-destructor)))))))
;; Home Environment:1 ends here

;; Mcron


;; [[file:Dotfiles.org::*Mcron][Mcron:1]]
   (service
    home-mcron-service-type
    (home-mcron-configuration
     (jobs
      (list
       #~(job '(next-minute '(0))
	      (string-append 
	       #$(file-append findutils "/bin/find")
	       " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -delete;"))
       #~(job
	      '(next-minute '(0))
	      "guix gc -F 80G")))))

   (service home-git-service-type
            (home-git-configuration
             (name "Michal Atlas")
             (email "michal_atlas+git@posteo.net")))
   ;; Mcron:1 ends here

   ;; [[file:Dotfiles.org::*Mcron][Mcron:2]]
   (simple-service
    'dotfiles
    home-files-service-type
    (map
     (match-lambda [(out in) `(,out ,(local-file in))])
     '((".emacs.d/init.el" "files/emacs.el")
       (".guile" "files/guile.scm")
       (".sbclrc" "files/sbcl.lisp")
       (".local/share/nyxt/bookmarks.lisp" "files/nyxt/bookmarks.lisp")
       (".config/nyxt/config.lisp" "files/nyxt/init.lisp"))))
   
   (service
    home-bash-service-type
    (home-bash-configuration
     (guix-defaults? #t)
     (bashrc
      (list
       (mixed-text-file "bashrc-direnv"
		        "eval \"$("
		        direnv "/bin/direnv"
		        " hook bash)\"")
       (plain-file "bashrc-ignoredups" "export HISTCONTROL=ignoredups")
       (mixed-text-file "bashrc-run"
		        "function run { "
		        guix "/bin/guix"
		        " shell $1 -- $@; }")
       (mixed-text-file "bashrc-valgrind"
		        "alias valgrind=\""
		        guix "/bin/guix"
		        " shell -CF valgrind -- valgrind \"")
       (mixed-text-file "bashrc-fasd" "eval \"$("
		        fasd "/bin/fasd"
		        " --init auto)\"")
       (mixed-text-file "bashrc-cheat"
		        "function cheat { "
		        curl "/bin/curl"
		        " \"cheat.sh/$@\"; }")))
     ;; Mcron:2 ends here

     ;; Aliases

     ;; [[file:Dotfiles.org::*Aliases][Aliases:1]]
     (aliases `
      (("gx" . "guix") ("gxi" . "gx install")
       ("gxb" . "gx build") ("gxs" . "gx search")
       ("gxsh" . "gx shell") ("gxtm" . "gx time-machine")
       ("e" . "$EDITOR") ("sw" . "swayhide")
       ("dd" . "dd status=progress")
       ("lem" . "sbcl --load ~/cl/setup.lisp --eval '(ql:quickload :lem-ncurses)' 00eval '(lem:lem)'")))
     ;; Aliases:1 ends here

     ;; Environment

     ;; [[file:Dotfiles.org::*Environment][Environment:1]]
     (environment-variables `
      (("BROWSER" . "firefox") ("EDITOR" . "emacsclient -n -c")
       ("TERM" . "xterm-256color") ("MOZ_ENABLE_WAYLAND" . "1")
       ("MOZ_USE_XINPUT2" . "1") ("GRIM_DEFAULT_DIR" . "~/tmp")
       ("_JAVA_AWT_WM_NONREPARENTING" . "1")
       ("PATH" . "$HOME/.nix-profile/bin/:$PATH")
       ("PATH" . "$PATH:$HOME/bin/")
       ("LD_LIBRARY_PATH" .
        ,(string-join
          (map
           (lambda (q) (string-append "/lib"))
           profiles)
          ":"))
       ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
       ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/dotfiles")
       ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/home/michal_atlas/.local/share/flatpak/exports/share")
       ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share")
       ("GUIX_SANDBOX_HOME" . "/GAMES"))
      )
     ;; Environment:1 ends here

     ;; [[file:Dotfiles.org::*Environment][Environment:2]]
     ))
;; Environment:2 ends here

;; [[file:Dotfiles.org::*Environment][Environment:3]]
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
	 		 (channel                   ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 (name 'emacs)              ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 (url "https://github.com/babariviere/guix-emacs") ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 (introduction              ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 (make-channel-introduction ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 "72ca4ef5b572fea10a4589c37264fa35d4564783" ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 (openpgp-fingerprint       ; ; ; ; ; ; ; ; ; ; ; ; ; ; ;
	 		 "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18"))))
	  %default-channels)
	 )
;; Environment:3 ends here

;; [[file:Dotfiles.org::*Environment][Environment:4]]
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
		       '("1" "2"))))
	  (authorized-keys (list (local-file "keys/hydra.pub")
				 (local-file "keys/dagon.pub")))))
;; Environment:4 ends here

;; [[file:Dotfiles.org::*Environment][Environment:5]]
)))
;; Environment:5 ends here
