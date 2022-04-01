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
  #:use-module (gnu home services mcron)
  #:use-module (ice-9 hash-table)
  #:use-module (guix gexp))

(home-environment
 (packages 
  (map specification->package
       (hash-ref %packages-by-host (vector-ref (uname) 1))))
 (services
  (list
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
	  '(next-minute '(0))
	  "find $HOME/tmp -mindepth 1 -ctime +2 -empty -delete | xargs rm -r")
       ))))
    (service home-bash-service-type
	    (home-bash-configuration
	     (guix-defaults? #t)))
   (simple-service
    'dotfiles
    home-files-service-type
    `(list ("ssh/config" ,(local-file "../../ssh"))
	   ("emacs.d/init.el" ,(local-file "../../emacs.el"))
	   ("guile" ,(local-file "../../guile"))
	   ("screenrc" ,(local-file "../../screen"))
	   ("config/kitty/kitty.conf" ,(local-file "../../kitty.conf"))
	   ("config/guix/channels.scm" ,(local-file "../../channels.scm"))
	   ("mbsyncrc" ,(local-file "../../.mbsyncrc"))))
   (service
    home-zsh-service-type
    (home-zsh-configuration
     (environment-variables
      `(("BROWSER" . "firefox")
	("SHELL" . "zsh")
	("EDITOR" . "\"emacsclient -a=\"\"\"")
	("XCURSOR_THEME" . "Adwaita")
        ("XCURSOR_SIZE" . "36")
	("TERM" . "xterm-256color")))
     (zshenv
      (list (local-file "../../zsh/env")))
     (zshrc
      (list (local-file "../../zsh/rc"))))))))
