(define-library (home)
  (import (scheme base)
          (gnu home)
          (atlas utils services)
          (home services)
          (only (guile) gethostname)
          (home packages))
  (export get-home)
  (begin
    (define (get-home host)
      (home-environment
       (packages %packages)
       (services (%services host))))

    (get-home (gethostname))))
