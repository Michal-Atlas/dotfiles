(define-library (home services git)
  (import (scheme base)
          (atlas utils services)
          (gnu home-services version-control))
  (export %git)
  (begin
    (define %git
      (&s home-git
          (config
           `((user
              ((name . "Michal Atlas")
               (email . "michal_atlas+git@posteo.net")
               (signingkey . "3EFBF2BBBB29B99E")))
             (commit
              ((gpgsign . #t)))
             (sendemail
              ((smtpserver . "posteo.de")
               (smtpserverport . 587)
               (smtpencryption . "tls")
               (smtpuser . ,(string-append
                             "michal_atlas"
                             "@"
                             "posteo.net"))))))))))
