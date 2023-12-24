(define-module (system mounts nfs)
  #:use-module (atlas utils services)
  #:use-module (gnu services nfs)

  #:export (nfs:get))

(define (nfs:get)
  (&s nfs
      (exports '(("/home/michal_atlas"
                  "dagon(ro) hydra(ro)")))))
