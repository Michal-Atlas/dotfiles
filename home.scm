(eval-when (expand load eval)
 (load "home-loads.scm"))

(home-environment
 (services
  (begin
    (load "home-loads.scm")
    (append
     (gather-services (string-append "home-" (gethostname)))
     (gather-services "home")))))
