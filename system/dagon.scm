(define-module (system dagon)
  #:use-module (atlas utils services)
  #:use-module (gnu services pm)
  #:use-module (gnu services pam-mount)
  #:use-module (gnu services base)
  #:use-module (gnu system file-systems)
  #:use-module (nongnu packages linux)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (dagon:services))

(define dagon:services
  (list
   (+s guix 'hydra-offload
       (guix-extension
        (build-machines
         (list
          #~(build-machine
             (name "hydra")
             (user "michal_atlas")
             (systems (list "x86_64-linux"))
             (private-key "/home/michal_atlas/.ssh/id_rsa")
             (host-key "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHp5iggvaDE3rbzNRteh6ckWVKicSFbTYMp1SeQYnRQ2"))))))
   (&s tlp
       (cpu-boost-on-ac? #t)
       (wifi-pwr-on-bat? #t))
   (+s firmware intel (list intel-microcode))))
