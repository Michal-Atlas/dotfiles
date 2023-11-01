(eval-when (expand load eval compile)
 (load "home-loads.scm"))

(define services
  (append
   (gather-services (string-append "home-" (gethostname)))
   (gather-services "home")))

(home-environment
 (services services))
