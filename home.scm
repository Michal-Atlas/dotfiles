(add-to-load-path (dirname (current-filename)))

(define-module (home)
  #:use-module (ice-9 match)
  #:use-module (gnu home)
  #:use-module (home services)
  #:use-module (home hydra)
  #:use-module (home unison)
  #:use-module (ice-9 match)
  #:export (home-by-host
            current-home))

(define services (make-parameter '()))

(define (get-home)
  (let ((services (services)))
   (home-environment
    (services services))))

(define (home-dagon)
  (parameterize ((unison-remote "hydra.local"))
    (parameterize ((services (get-services)))
      (get-home))))

(define (home-hydra)
  (parameterize ((unison-remote "dagon.local"))
    (parameterize ((services (append (hydra:services)
                                     (get-services))))
      (get-home))))

(define (home-by-host host)
  ((match host
     ("dagon" home-dagon)
     ("hydra" home-hydra))))

(define current-home
  (home-by-host (gethostname)))

current-home
