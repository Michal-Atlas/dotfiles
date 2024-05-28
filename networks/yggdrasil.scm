(define-module (networks yggdrasil)
  #:use-module (atlas utils services)
  #:use-module (gnu services networking)
  #:use-module (gnu services base)
  #:use-module (ice-9 match)
  #:use-module (rde features)
  #:use-module ((rde features networking) #:prefix rde:)
  #:use-module (srfi srfi-43)
  #:export (feature-yggdrasil))

(define (feature-yggdrasil . rest)
  (define (get-system-services config)
    (list
     (+s hosts yggdrasil-hosts
         (map (match-lambda
                [(name . addr)
                 (host
                  (string-join addr ":")
                  (string-append "yg-" name))])
              `(("hydra" .
                 ("200" "6229" "6335" "8721"
                  "7ae1" "6b30" "961e" "c172"))
                ("dagon" .
                 ("200" "2b5a" "7e80" "7b31"
                  "7d15" "6c81" "2563" "62c"))
                ("lana" .
                 ("200" "29bd" "a495" "4ad7"
                  "f79e" "e29a" "181a" "3872"))
                ("leviathan" .
                 ("201" "a948" "e5b3" "2c4c"
                  "378c" "5d3b" "54c6" "920f")))))
     (&s yggdrasil
         ;(config-file "/run/secrets/yggdrasil.json")
         (json-config
          `((peers .
                   ,(vector-append
                    #("tls://37.205.14.171:993"
                      "tls://[2a03:3b40:fe:ab::1]:993")
                    (@@ (rde features networking) yggdrasil-default-peers))))))))
  (feature
   (system-services-getter get-system-services)))