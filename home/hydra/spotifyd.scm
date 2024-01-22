(define-module (home hydra spotifyd)
  #:use-module (atlas utils services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages rust-apps)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (guix gexp)
  #:export (hydra:spotifyd))

(define (hydra:spotifyd)
  (+s home-shepherd spotifyd
      (list
       (shepherd-service
        (provision '(spotifyd))
        (start
         #~(make-forkexec-constructor
            (list
             #$(file-append spotifyd "/bin/spotifyd")
             "--no-daemon")))
        (stop #~(make-kill-destructor))))))
