(load "home-loads.scm")
(use-modules (ice-9 control))

(define (gather-services dir)
  (list-transduce
   (compose (tlog (lambda (result input)
                    (format #t ";; Loading services from: ~a~%"
                            input)))
            (tmap load)
            tflatten)
   rcons
   (%
    (begin
      (nftw dir
            (lambda (filename _ flag . a)
              (if (eq? flag 'regular)
                  (abort
                   (lambda (k) (cons filename (k #t))))
                  #t))
            #f)
      '()))))

(home-environment
 (services
  (append
   (gather-services (string-append "home-" (gethostname)))
   (gather-services "home"))))
