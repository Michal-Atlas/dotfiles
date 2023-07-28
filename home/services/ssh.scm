(define-library (home services ssh)
  (import (scheme base)
          (guile)
          (guix gexp)
          (atlas utils services)
          (gnu home services ssh))
  (export %ssh)
  (begin
    (define %ssh
      (&s home-openssh
          (hosts (append
	          (list
	           (openssh-host
	            (name "Myst")
	            (host-name "34.122.2.188"))
	           (openssh-host
	            (name "ZmioSem")
	            (user "michal_zacek")
	            (port 10169)
	            (host-name "hiccup.mazim.cz"))
                   (openssh-host
                    (name "the-dam")
                    (user "atlas")
                    (host-name "the-dam.org")
                    (identity-file (string-append
                                    (getenv "HOME")
                                    "/.ssh/the-dam"))))
	          (map (lambda (q)
		         (openssh-host
		          (name (string-append "Fray" q))
		          (host-name (string-append "fray" q ".fit.cvut.cz"))
		          (user "zacekmi2")
		          (host-key-algorithms (list "+ssh-rsa"))
		          (accepted-key-types (list "+ssh-rsa"))
		          (extra-content "  ControlMaster auto")))
	               '("1" "2"))))
          (authorized-keys (list (local-file "keys/hydra.pub")
			         (local-file "keys/dagon.pub")
                                 (local-file "keys/arc.pub")))))))
