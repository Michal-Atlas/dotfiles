(define-library (home services shepherd)
  (import (scheme base)
          (atlas utils services)
          (guix gexp)
          (gnu home services shepherd)
          (gnu packages freedesktop))
  (export %shepherd)
  (begin
    (define %shepherd
      (&s home-shepherd
          (services
           (list
            (shepherd-service
             (provision '(disk-automount))
             (start #~(make-forkexec-constructor
	               (list #$(file-append udiskie "/bin/udiskie"))))
             (stop #~(make-kill-destructor)))))))))
