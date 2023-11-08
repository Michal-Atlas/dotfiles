(define-module (home ssh)
  #:use-module (atlas utils services)
  #:use-module (gnu home services ssh)
  #:use-module (guix gexp)
  #:export (ssh))

(define ssh
 (&s home-openssh
     (hosts (append
	     (list
	      (openssh-host
	       (name "Myst")
	       (host-name "34.122.2.188"))
              (openssh-host
               (name "sps06")
               (user "student")
               (host-name "***REMOVED***")
               (identity-file (string-append
                               (getenv "HOME")
                               "/.ssh/sps")))
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
                               "/.ssh/the-dam")))
              (openssh-host
               (name "metacentrum-plzen1")
               (host-name "alfrid.meta.zcu.cz")))
	     (map (lambda (q)
		    (openssh-host
		     (name (string-append "Fray" q))
		     (host-name (string-append "fray" q ".fit.cvut.cz"))
		     (user "zacekmi2")
		     (host-key-algorithms (list "+ssh-rsa"))
		     (accepted-key-types (list "+ssh-rsa"))
		     (extra-content "  ControlMaster auto")))
	          '("1" "2"))))
     (authorized-keys (list (local-file "../keys/hydra.pub")
			    (local-file "../keys/dagon.pub")
                            (local-file "../keys/arc.pub")))))
