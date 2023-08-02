(define-library (home)
  (import (scheme base)
          (gnu home)
          (utils services)
          (home services)
          (only (guile) uname)
          (home packages))
  (export get-home)
  (begin
    (define (get-home host)
      (home-environment
       (packages %packages)
       (services (%services host))))

    (get-home (vector-ref (uname) 1))))
