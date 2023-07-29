(define-library (home)
  (import (scheme base)
          (gnu home)
          (utils services)
          (home services)
          (home packages))
  (export get-home)
  (begin
    (define (get-home host)
      (home-environment
       (packages %packages)
       (services (%services host))))))
