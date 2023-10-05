(define-module (atlas config home)
  #:use-module (gnu home)
  #:use-module (atlas config home services)
  #:use-module (atlas config home packages)
  #:use-module (atlas combinators))

(define-public (get-home host)
  (-> (home-environment)
      %packages
      %services))

(get-home (gethostname))
