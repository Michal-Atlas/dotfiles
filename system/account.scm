(define-module (system account)
  #:use-module (atlas utils services)
  #:use-module (gnu system shadow)
  #:export (accounts))

(define-public accounts
  (+s account atlas
      (list
       (user-account
        (name "michal_atlas")
        (comment "Michal Atlas")
        (group "users")
        (home-directory "/home/michal_atlas")
        (supplementary-groups
         '("wheel" "netdev" "audio"
           "video" "libvirt" "kvm" "tty"))))))
