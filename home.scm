(load "home-loads.scm")
(use-modules (atlas utils services))

(home-environment
 (services
  (append
   (gather-services (string-append "home-" (gethostname)))
   (gather-services "home"))))
