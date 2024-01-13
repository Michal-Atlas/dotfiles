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
  #:use-module (gnu packages networking)
  #:use-module (gnu packages web)
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
         (stop #~(make-kill-destructor)))))
   (+s home-shepherd kineto+pagekite
       (list
        (shepherd-service
         (provision '(kineto))
         (start #~(make-forkexec-constructor
                   (list #$(file-append kineto "/bin/kineto")
                         "gemini://michal_atlas.srht.site")))
         (stop #~(make-kill-destructor)))
        (shepherd-service
         (provision '(gmnisrv))
         (start #~(make-forkexec-constructor
                   (list #$(file-append gmnisrv "/bin/gmnisrv")
                         "-C" #$(plain-file "gmnisrv.ini"
                                            "listen=0.0.0.0 [::]

[:tls]
store=certs

[hydra]
root=/home/michal_atlas/Pictures/CC0
autoindex=on"))))
         (stop #~(make-kill-destructor)))

        (shepherd-service
         (provision '(pagekite))
         (start #~(make-forkexec-constructor
                   (list #$(file-append pagekite "/bin/pagekite")
                         "http:matlas.pagekite.me:localhost:8080:")))
         (stop #~(make-kill-destructor)))))))
