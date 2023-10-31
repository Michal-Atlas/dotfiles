(load "home-loads.scm")

(home-environment
 (services
  (append
   (gather-services (string-append "home-" (gethostname)))
   (gather-services "home"))))
