(define-module (networks zerotier)
  #:use-module (atlas utils services)
  #:use-module (nongnu services vpn)
  #:use-module (guix gexp)
  #:use-module (gnu packages admin)
  #:use-module (gnu services shepherd)

  #:export (zerotier-network
            zerotier:get))

(define zerotier-network
  (make-parameter (string-reverse "7d36f91fa2718c7c")))

(define (zerotier:get)
  (list
   (zerotier-one-service)
   (+s shepherd-root join-zerotier
       (list
        (shepherd-service
         (provision '(zerotier-join))
         (requirement '(zerotier-one))
         (one-shot? #t)
         (start #~(make-forkexec-constructor
                   (list #$(file-append shepherd "/bin/herd")
                         "join" "zerotier-one" #$(zerotier-network))))
         (stop #~(make-kill-destructor)))))))
