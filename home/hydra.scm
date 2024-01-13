(define-module (home hydra)
  #:use-module (atlas utils services)
  #:use-module (home hydra spotifyd)
  #:use-module (gnu packages base)
  #:use-module (guix gexp)
  #:use-module (gnu home services mcron)
  #:use-module (gnu home services messaging)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages sync)
  #:use-module (gnu packages ocaml)
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
                    "Onedrive")
             #~(job "*/5 * * * *"
                    #$(file-append coreutils "/bin/touch ~/Sync/.forcesync")
                    "Unison Toucher")))

   (+s home-shepherd unison
       (list
        (shepherd-service
         (provision '(sync unison))
         (start #~(make-forkexec-constructor
                   (list
                    #$(file-append unison "/bin/unison")
                    "-repeat=watch"
                    "-batch")
                   #:log-file (string-append %user-log-dir "/unison.log")))
         (stop #~(make-kill-destructor)))))))
