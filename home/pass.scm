(define-module (home pass)
  #:use-module (gnu home-services password-utils)
  #:use-module (atlas utils services)
  #:export (pass))

(define pass
  (&s home-password-store
      (browserpass-native? #t)))
