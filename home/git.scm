(&s home-git
    (config
     `((user
        ((name . "Michal Atlas")
         (email . "michal_atlas+git@posteo.net")
         (signingkey . "3EFBF2BBBB29B99E")))
       (pull
        ((rebase . #t)))
       (rebase
        ((autostash . #t)))
       (commit
        ((gpgsign . #t)))
       (sendemail
        ((smtpserver . "posteo.de")
         (smtpserverport . 587)
         (smtpencryption . "tls")
         (smtpuser . ,(string-append
                       "michal_atlas"
                       "@"
                       "posteo.net")))))))