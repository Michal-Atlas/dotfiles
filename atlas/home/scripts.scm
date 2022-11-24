(define-module (atlas home scripts)
  #:use-module (guix gexp)
  #:use-module (srfi srfi-98)
  #:use-module (gnu packages guile)
  #:export (scripts))

(define scripts (make-parameter '()))

(define-syntax-rule (define-script name body ...)
  (scripts (cons `(,(format #f "bin/guix/scripts/~a.scm" 'name)
		   ,(program-file
		     (symbol->string 'name)
		     #~(begin
			 (define-module (guix scripts #$ 'name))
			 body ...)
		     #:guile guile-3.0-latest)) (scripts))))

(define-script test
  (display (+ 2 3)))

(define home (get-environment-variable "HOME"))
(define channel-lock-file (string-append home "/dotfiles/channels.lock"))
(define dotfile-dir (string-append home "/dotfiles"))
(define home-config (string-append home "/dotfiles/atlas/home/home.scm"))
(define base-config (string-append home "/dotfiles/atlas/system/base.scm"))

(define-script recon-home
  (system*
   "guix" "time-machine"
   "-C" #$channel-lock-file
   "--" "home" "reconfigure" "-L"
   #$dotfile-dir
   #$home-config))

(define-script recon-system
  (system*
   "sudo" "guix" "time-machine" "-C" #$channel-lock-file
   "--" "system" "reconfigure" "-L"
   #$dotfile-dir
   #$base-config))

(define-script update-locks
  (system*
   "guix" "pull")
  (with-output-to-file #$channel-lock-file
    (lambda () (display
	   ((@ (ice-9 textual-ports) get-string-all)
	    ((@ (ice-9 popen) open-pipe*)
	     OPEN_READ "guix" "describe" "--format=channels"))))))

(define-script patch
  (use-modules (srfi srfi-26))
  (let ([target (cadr (command-line))])
   (system* "patchelf" target "--set-rpath"
	    (string-append
	     "\"/run/current-system/profile/lib:/home/"
	     (getlogin)
	     "/.guix-home/profile/lib"
	     (apply string-append
		    (map (cut string-append ":" <> "/lib")
			 (string-split
			  ((@ (ice-9 textual-ports) get-string-all)
			   ((@ (ice-9 popen) open-pipe*)
			    OPEN_READ "guix" "package" "--list-profiles"))
			  #\newline)))
	     "\""))
   (system*
    "patchelf" target
    "--set-interpreter"
    "\"/run/current-system/profile/lib/ld-linux-x86-64.so.2\"")
   (display (format #t "RPATH: ~aLD: ~a"
		    ((@ (ice-9 textual-ports) get-string-all)
		     ((@ (ice-9 popen) open-pipe*)
		      OPEN_READ "patchelf" target "--print-rpath"))
		    ((@ (ice-9 textual-ports) get-string-all)
		     ((@ (ice-9 popen) open-pipe*)
		      OPEN_READ "patchelf" target "--print-interpreter"))))))
