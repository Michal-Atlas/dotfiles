(define-module (home)
  #:use-module (atlas utils define)
  #:use-module (ice-9 match)
  #:use-module (gnu home)
  #:use-module (home services)
  #:use-module (home hydra)
  #:export (get-home))

(define/cp pass (get-home extra-services)
  (home-environment
   (services
    (append
     extra-services
     (pass configure-services)))))

(apply get-home
       (match (gethostname)
         ("dagon"
          (list #:extra-services '()))
         ("hydra"
          (list #:extra-services hydra:services))))
