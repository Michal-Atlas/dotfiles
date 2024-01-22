(define-module (mounts nfs)
  #:use-module (atlas utils services)
  #:use-module (gnu services nfs)

  #:export (nfs:get))

(define (nfs:get)
  (&s nfs
      (exports '(("/home/michal_atlas"
                  "fd4c:16e4:7d9b::/64(rw,crossmnt)")))))
