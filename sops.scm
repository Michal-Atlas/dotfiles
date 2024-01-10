(define-module (sops)
  #:use-module (atlas utils services)
  #:use-module (sops services sops)
  #:use-module (guix gexp)
  #:export (sops.yaml
            common.yaml
            sops-service))

(define sops.yaml
  (local-file "sops.yaml"))

(define common.yaml
  (local-file "common.yaml"))

(define sops-service
  (&s sops-secrets #:config
      (sops-service-configuration
       (generate-key? #t)
       (config sops.yaml))))
