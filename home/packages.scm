(define-library (home packages)
  (import (scheme base)
          (gnu packages terminals)
          (games packages minecraft))
  (export %packages)
  (begin
    (define (%packages)
      (list foot
            prismlauncher))))
