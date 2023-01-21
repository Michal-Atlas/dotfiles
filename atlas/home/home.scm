(define-module (atlas home home)
  #:use-module (atlas home packages)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services fontutils)
  #:use-module (gnu home services guix)
  #:use-module (guix channels)
  #:use-module (gnu services)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu services xorg)
  #:use-module (gnu home services mcron)
  #:use-module (ice-9 hash-table)
  #:use-module (guix gexp))

(home-environment
 (packages
  (map (λ (f)
	 (if (list? f)
	     (apply specification->package+output f)
	     (specification->package f)))
       (hash-ref %packages-by-host (vector-ref (uname) 1))))
 (services
  (list
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
		(auto-start? #f)
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
       #~(job
	  '(next-minute '(5))
	  "mbsync --all")
       #~(job
	  '(next-hour '(0))
	  "guix gc -F 10G")
       #~(job
	  '(next-hour '(0))
	  "mkdir -p ~/tmp-log; mv ~/tmp ~/tmp-log/$(date -I); mkdir ~/tmp")
       ))))
   (simple-service
    'dotfiles
    home-files-service-type
    `((".emacs.d/init.el" ,(local-file "../../emacs.el"))
      (".guile" ,(local-file "../../guile"))
      (".screenrc" ,(local-file "../../screen"))
      (".mbsyncrc" ,(local-file "../../mbsyncrc"))))
   (simple-service
    'dotfiles-xdg
    home-xdg-configuration-files-service-type
    `(("sway/config" ,(local-file "../../sway.cfg"))
      ("foot/foot.ini" ,(local-file "../../foot.ini"))))
					;(".sbclrc" ,(local-file "../../sbclrc"))
					;(".emacs.d/eshell/alias" ,(local-file "../../eshell-alias"))
      
   (service
    home-bash-service-type
    (home-bash-configuration
     (guix-defaults? #t)
     (bashrc
      (list
       (plain-file "bashrc-direnv" "eval \"$(direnv hook bash)\"")
       (plain-file "bashrc-ignoredups" "export HISTCONTROL=ignoredups")
       (plain-file "bashrc-run" "function run { guix shell $1 -- $@; }")
       (plain-file "bashrc-valgrind" "alias valgrind=\"guix shell -CF valgrind -- valgrind \"")
       (plain-file "bashrc-fasd" "eval \"$(fasd --init auto)\"")
       (plain-file "bashrc-cheat" "function cheat { curl \"cheat.sh/$@\"; }")))
     (aliases
      `(("gx" . "guix")
	("gxi" . "gx install")
	("gxb" . "gx build")
	("gxs" . "gx search")
	("gxsh" . "gx shell")
	("gxtm" . "gx time-machine")
	("e" . "$EDITOR")
	("sw" . "swayhide")))
     (environment-variables
      `(("BROWSER" . "firefox")
	("EDITOR" . "emacsclient -n -c")
	("TERM" . "xterm-256color")
	("MOZ_ENABLE_WAYLAND" . "1")
	("MOZ_USE_XINPUT2" . "1")
	("GRIM_DEFAULT_DIR" . "~/tmp")
	("_JAVA_AWT_WM_NONREPARENTING" . "1")
	("XDG_CURRENT_DESKTOP" . "sway")
	("PATH" . "$PATH:$HOME/.nix-profile/bin/")
	("GUILE_LOAD_PATH" . "$GUILE_LOAD_PATH:$HOME/bin")
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
	     (channel
	      (name 'emacs)
	      (url "https://github.com/babariviere/guix-emacs")
	      (introduction
	       (make-channel-introduction
		"72ca4ef5b572fea10a4589c37264fa35d4564783"
		(openpgp-fingerprint
		 "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18"))))
	     %default-channels))
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
	     (authorized-keys (list (local-file "../../keys/hydra.pub")
				    (local-file "../../keys/dagon.pub")))))
   )))
