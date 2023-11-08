(define-module (home mcron)
  #:use-module (gnu home services mcron)
  #:use-module (atlas utils services)
  #:use-module (guix gexp)
  #:use-module (gnu packages base)
  #:use-module (gnu packages containers)
  #:export (mcron))

(define mcron
 (&s home-mcron
     (jobs
      (list
       #~(job "0 * * * *"
              (string-append
               #$(file-append findutils "/bin/find")
               " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -ctime +2 -delete;")
              "Clear tmpfiles")
       #~(job "0 * * * *"
	      "guix gc -F 20G")
       #~(job "0 0 * * 0"
              #$(file-append podman "/bin/podman container prune -f")
              "podman prune containers")
       #~(job "0 0 * * 0"
              #$(file-append podman "/bin/podman image prune -f")
              "podman prune images")))))
