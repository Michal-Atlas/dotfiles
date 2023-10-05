(define-module (system packages)
  #:use-module (gnu system)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages certs))

(define-public %packages
  (cons*
   nss-certs
   %base-packages))
