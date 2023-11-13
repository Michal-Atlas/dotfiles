(define-module (home)
  #:use-module (ice-9 match)
  #:use-module (gnu home)
  #:use-module (home services)
  #:use-module (home hydra)
  #:export (get-home))

(define services (make-parameter '()))

(define (get-home)
  (let ((services (services)))
   (home-environment
    (services services))))

(match (gethostname)
  ("dagon"
   (parameterize
       ((services (get-services)))
     (get-home)))
  ("hydra"
   (parameterize
       ((services
         (append (hydra:services)
                 (get-services))))
     (get-home))))
