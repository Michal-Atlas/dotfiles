(define-library (system packages)
  (import (scheme base)
          (gnu system)
          (only (guile) cons*)
          (gnu packages gnome)
          (gnu packages kde-frameworks)
          (gnu packages package-management)
          (gnu packages certs))
  (export %packages)
  (begin
    (define %packages
      (cons*
       nss-certs
       %base-packages))))
