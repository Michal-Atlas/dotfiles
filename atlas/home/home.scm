(define-module (atlas home home)
  #:use-module (atlas packages home)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu services)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages emacs)
  #:use-module (gnu home services mcron)
  #:use-module (guix gexp))

(home-environment
 (packages %home-desktop-manifest)
 (services
  (list
   (service
    home-mcron-service-type
    (home-mcron-configuration
     (jobs
      (list
       #~(job
	  '(next-minute '(5))
	  "mbsync --all")))))
   (service
    home-shepherd-service-type
    (home-shepherd-configuration
     (services
      (list
       (shepherd-service
	(provision  '(emacs))
	(documentation "Run `emacs' on startup")
	(start #~(make-forkexec-constructor
		  (list
		   #$(file-append emacs-next "/bin/emacs")
		   "--fg-daemon")
		  #:user "michal-atlas"
		  #:environment-variables
		  (cons*
		   "GDK_SCALE=2"
		   "GDK_DPI_SCALE=0.41"
		   (default-environment-variables))))
	(stop #~(make-system-destructor
		 "emacsclient -e '(save-buffers-kill-emacs)'"))
	(respawn? #t))))))
   (service home-bash-service-type
	    (home-bash-configuration
	     (guix-defaults? #t)))
   (simple-service
    'dotfiles
    home-files-service-type
    (list `("ssh/config" ,(local-file "../../ssh"))
	  `("emacs.d/init.el" ,(local-file "../../emacs.el"))
	  `("guile" ,(local-file "../../guile"))
	  `("screenrc" ,(local-file "../../screen"))))
   (service
    home-zsh-service-type
    (home-zsh-configuration
     (environment-variables
      `(("BROWSER" . "firefox")
	("SHELL" . "zsh")
	("EDITOR" . "\"emacsclient -c\"")
	("XCURSOR_THEME" . "Adwaita")
        ("XCURSOR_SIZE" . "36")))
     (zshenv
      (list (local-file "../../zsh/env")))
     (zshrc
      (list (local-file "../../zsh/rc"))))))))
