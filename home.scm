(define-library (home)
  (import (scheme base)
          (gnu home)
          (utils services)
          (home services)
          (home packages))
  (export %home)
  (begin
    (define (get-home host)
      (parameterize ((hostname host))
        (%home)))
    
    (define (%home)
      (home-environment
       (packages (%packages))
       (services (%services))))))
