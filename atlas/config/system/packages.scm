(define-module (atlas config system packages)
  #:use-module (atlas combinators)
  #:use-module (gnu))

(use-package-modules   
 certs)

(define-public %packages
  (packages nss-certs))
