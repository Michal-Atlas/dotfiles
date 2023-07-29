(define-library (home)
  (import (scheme base)
          (gnu home)
          (home services)
          (home packages))
  (export %home)
  (begin
    (define (%home)
      (home-environment
       (packages (%packages))
       (services (%services))))))
