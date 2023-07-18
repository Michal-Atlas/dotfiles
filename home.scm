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
 (atlas home services git)
 (atlas home services flatpak))
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
	      "guix gc -F 20G")))))

   (service home-git-service-type
            (home-git-configuration
             (name "Michal Atlas")
             (email "michal_atlas+git@posteo.net")))
   ;; Mcron:1 ends here

   ;; [[file:Dotfiles.org::*Mcron][Mcron:2]]
   (simple-service
    'dotfiles
    home-files-service-type
    ;; local-file being explicit allows earlier check for file existencex
    `((".emacs.d/init.el" ,(local-file "files/emacs.el"))
      (".guile" ,(local-file "files/guile.scm"))
      (".sbclrc" ,(local-file "files/sbcl.lisp"))
      (".local/share/nyxt/bookmarks.lisp" ,(local-file "files/nyxt/bookmarks.lisp"))
      (".config/nyxt/config.lisp" ,(local-file "files/nyxt/init.lisp"))))
   
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
       ("dd" . "dd status=progress")))
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
       ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
       ("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/dotfiles")
       ("GUIX_SANDBOX_HOME" . "/GAMES")
       ("ALTERNATE_EDITOR" . ""))
      )
     ;; Environment:1 ends here

     ;; [[file:Dotfiles.org::*Environment][Environment:2]]
     ))
;; Environment:2 ends here

;; [[file:Dotfiles.org::*Environment][Environment:3]]
(service home-channels-service-type (load "channels.scm"))
;; Environment:3 ends here

(service home-flatpak-service-type
         (home-flatpak-configuration
          (packages
           '(("flathub"
              "com.discordapp.Discord"
              "com.spotify.Client")))))

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
		    (host-name "hiccup.mazim.cz"))
                   (openssh-host
                    (name "the-dam")
                    (user "atlas")
                    (host-name "the-dam.org")
                    (identity-file (string-append
                                    (getenv "HOME")
                                    "/.ssh/the-dam"))))
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
				 (local-file "keys/dagon.pub")
                                 (local-file "keys/arc.pub")))))
;; Environment:4 ends here

;; [[file:Dotfiles.org::*Environment][Environment:5]]
)))
;; Environment:5 ends here
