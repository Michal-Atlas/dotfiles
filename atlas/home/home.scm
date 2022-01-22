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
   ;; (service
   ;;  home-zsh-service-type
   ;;  (home-zsh-configuration
   ;;   (zshenv
   ;;    '("/home/michal-atlas/dotfiles/home/.zshenv"
   ;; 	;; "[ -f \"$HOME/.cargo/env\" ] && . \"$HOME/.cargo/env\" || true"
   ;; 	;; "export RUST_SRC_PATH=\"$(rustc --print sysroot)/lib/rustlib/src/rust/library\""
   ;; 	;; "setopt -w0U"
   ;; 	;; "setopt auto_continue"
   ;; 	;; "setopt no_hup"
   ;; 	;; "setopt pipe_fail"
   ;; 	;; "GUIX_PROFILE=\"/home/michal-atlas/.guix-profile\""
   ;; 	;; ". \"$GUIX_PROFILE/etc/profile\""
   ;; 	))))
   )))
