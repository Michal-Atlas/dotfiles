(define-module (atlas home home)
  #:use-module (atlas packages home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
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
		(provision '(emacs))
		(start #~(make-forkexec-constructor
			  (list
			   #$(file-append emacs-next "/bin/emacs")
			   "--fg-daemon")
			  #:environment-variables
			  (cons*
			   "GDK_SCALE=2"
			   "GDK_DPI_SCALE=0.41"
			   (default-environment-variables))))
		(stop #~(make-system-destructor
			 "emacsclient -e '(save-buffers-kill-emacs)'")))

	       (shepherd-service
		(provision '(sway))
		(respawn? #f)
		(start #~(make-forkexec-constructor
			  (list #$(file-append sway "/bin/sway"))))
		(stop #~(make-kill-destructor)))))))
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
    `((".ssh/config" ,(local-file "../../ssh"))
      (".emacs.d/init.el" ,(local-file "../../emacs.el"))
      (".guile" ,(local-file "../../guile"))
      (".screenrc" ,(local-file "../../screen"))
      (".config/guix/channels.scm" ,(local-file "../../channels.scm"))
      (".mbsyncrc" ,(local-file "../../mbsyncrc"))
      (".config/sway/config" ,(local-file "../../sway.cfg"))
      (".config/foot/foot.ini" ,(local-file "../../foot.ini"))
      (".sbclrc" ,(local-file "../../sbclrc"))
      (".emacs.d/eshell/alias" ,(local-file "../../eshell-alias"))))
   (service
    home-bash-service-type
    (home-bash-configuration
     (guix-defaults? #t)
     (bashrc
      (list
       (plain-file "bashrc" "eval \"$(direnv hook bash)\"")))
     (aliases
      `(("gx" . "guix")
	("gxi" . "gx install")
	("gxb" . "gx build")
	("gxsh" . "gx shell")
	("gxtm" . "gx time-machine")
	("e" . "$EDITOR")
	("sw" . "swayhide")))
     (environment-variables
      `(("BROWSER" . "firefox")
	("EDITOR" . "emacsclient")
	("TERM" . "xterm-256color")
	("MOZ_ENABLE_WAYLAND" . "1")
	("MOZ_USE_XINPUT2" . "1")
	("GRIM_DEFAULT_DIR" . "~/tmp")
	("_JAVA_AWT_WM_NONREPARENTING" . "1")
	("XDG_CURRENT_DESKTOP" . "sway")
	("PATH" . "$PATH:$HOME/.nix-profile/bin/")
	("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/michal_atlas/.local/share/flatpak/exports/share"))))))))
