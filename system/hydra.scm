(define-module (system hydra)
  #:use-module (atlas utils services)
  #:use-module (gnu services)
  #:use-module (nongnu packages linux)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services cuirass)
  #:use-module (guix gexp)
  #:use-module (gnu services pam-mount)
  #:use-module (gnu services messaging)
  #:use-module (gnu services docker)
  #:use-module (atlas services morrowind)
  #:export (hydra:services))

(define hydra:services
  (list
   (+s firmware amd (list amdgpu-firmware))
   (&s hurd-vm)
   (&s docker)
   (+s oci-container jellyfin
       (list
        (oci-container-configuration
         (image "jellyfin/jellyfin")
         (ports '(("8096" . "8096")))
         (network "host")
         (volumes '("jellyfin-config:/config"
                    "jellyfin-cache:/cache"
                    "/shares/router-disk/Movies/:/media:ro")))))
   (&s tes3mp-server)))
