(define-module (home hydra)
  #:use-module (atlas utils services)
  #:use-module (home hydra spotifyd)
  #:use-module (guix gexp)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services messaging)
  #:use-module (gnu packages sync)
  #:export (hydra:services))

(define (hydra:services)
  (list
   (&s home-znc)
   (hydra:spotifyd)
   (+s home-mcron hydra-extensions
       (list #~(job "0 6 * * *"
                    (string-append
                     #$(file-append onedrive "/bin/onedrive")
                     " --synchronize")
                    "Onedrive")))))
