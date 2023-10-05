(define-module (atlas system packages)
  #:use-module (atlas utils combinators)
  #:use-module (gnu))

(use-package-modules   
 certs)

(define-public %packages
  (packages nss-certs))
