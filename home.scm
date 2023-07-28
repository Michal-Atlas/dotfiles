(define-library (home)
  (import (scheme base)
          (scheme lazy)
          (gnu home)
          (home services)
          (home packages))
  (export %home)
  (begin
    (define %home
      (delay
       (home-environment
        (packages %packages)
        (services (force %services)))))))
