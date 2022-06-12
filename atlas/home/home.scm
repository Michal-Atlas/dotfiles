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
  #:use-module (gnu home services mcron)
  #:use-module (ice-9 hash-table)
  #:use-module (guix gexp))

(home-environment
 (packages 
  (map specification->package
       (hash-ref %packages-by-host (vector-ref (uname) 1))))
 (services
  (list
   (service home-shepherd-service-type
	    (home-shepherd-configuration
	     (services (list
			(shepherd-service
			 (provision '(emacs))
			 (start #~(make-forkexec-constructor
				   (list
				    #$(file-append emacs-next "/bin/emacs")
				    "--fg-daemon")
				   #:user "michal_atlas"
				   #:environment-variables
				   (cons*
				    "GDK_SCALE=2"
				    "GDK_DPI_SCALE=0.41"
				    (default-environment-variables))))
			 (stop #~(make-system-destructor
				  "emacsclient -e '(save-buffers-kill-emacs)'")))
			(shepherd-service
			 (provision '(sway))
			 (start #~(make-forkexec-constructor
				   (list #$(file-append sway "/bin/sway"))
				   #:user "michal_atlas"))
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
   #;(simple-service
   'run-sway-on-login
   home-run-on-first-login-service-type
   #~(system "sway"))
   (simple-service
    'dotfiles
    home-files-service-type
    `((".ssh/config" ,(local-file "../../ssh"))
      #;(".emacs.d/init.el" ,(local-file "../../emacs.el"))
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
     (environment-variables
      `(("BROWSER" . "firefox")
	("EDITOR" . "\"emacsclient -nw -a=\"\"\"")
	("TERM" . "xterm-256color")
	("MOZ_ENABLE_WAYLAND" . "1")
	("GRIM_DEFAULT_DIR" . "~/tmp")
	("_JAVA_AWT_WM_NONREPARENTING" . "1")
	("XDG_CURRENT_DESKTOP" . "sway"))))))))
