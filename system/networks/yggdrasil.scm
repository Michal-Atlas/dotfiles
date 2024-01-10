(define-module (system networks yggdrasil)
  #:use-module (atlas utils services)
  #:use-module (gnu services networking)
  #:use-module (gnu services base)
  #:use-module (ice-9 match)
  #:use-module (system hostname)
  #:use-module (sops)
  #:use-module (sops services sops)
  #:export (yggdrasil:get))


(define (yggdrasil:get)
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
                "f79e" "e29a" "181a" "3872")))))

   (&s yggdrasil
       (json-config
        '((peers .
                 #("tls://37.205.14.171:993"
                   "tls://ygg.yt:443"))))
       (config-file "/run/secrets/yggdrasil.conf"))
   (+s sops-secrets sops-wireguard
       (list
        (sops-secret
         (key `("yggdrasil" ,(hostname)))
         (file common.yaml)
         (output-type "json")
         (path "yggdrasil.conf"))))))
