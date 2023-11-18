(define-module (system hydra)
  #:use-module (atlas utils services)
  #:use-module (gnu services)
  #:use-module (nongnu packages linux)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services cuirass)
  #:use-module (guix gexp)
  #:use-module (gnu services messaging)
  #:use-module (atlas services morrowind)
  #:export (hydra:services))

(define hydra:services
  (list
   (+s firmware amd (list amdgpu-firmware))
   (&s hurd-vm)
   (&s cuirass
       (interval (* 24 60 60))
       (host "0.0.0.0")
       (use-substitutes? #t)
       (specifications
        #~(list (specification
                 (name "atlas")
                 (build '(channels atlas))
                 (channels
                  (cons
                   (channel
                    (name 'atlas)
                    (url "https://git.sr.ht/~michal_atlas/guix-channel")
                    (introduction
                     (make-channel-introduction
                      "f0e838427c2d9c495202f1ad36cfcae86e3ed6af"
                      (openpgp-fingerprint
                       "D45185A2755DAF831F1C3DC63EFBF2BBBB29B99E"))))
                   %default-channels))))))
   (&s tes3mp-server)))
