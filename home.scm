(add-to-load-path (dirname (current-filename)))

(define-module (home)
  #:use-module (ice-9 match)
  #:use-module (gnu home)
  #:use-module (home services)
  #:use-module (home hydra)
  #:use-module (home unison)
  #:export (get-home))

(define services (make-parameter '()))

(define (get-home)
  (let ((services (services)))
   (home-environment
    (services services))))

(match (gethostname)
  ("dagon"
   (parameterize
       ((services (get-services))
        (unison-remote "hydra.local"))
     (get-home)))
  ("hydra"
   (parameterize
       ((services
         (append (hydra:services)
                 (get-services)))
        (unison-remote "dagon.local"))
     (get-home))))
