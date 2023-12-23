(define-module (system mounts autofs)
  #:use-module (atlas utils services)
  #:use-module (gnu packages file-systems)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)

  #:export (autofs:get))

(define autofs-shares
  (mixed-text-file
   "auto.shares"
   "router-disk -fstype=cifs,vers=1.0,password=1.0 ://192.168.0.1/sda1\n"
   "\n"))

(define autofs-config
  (mixed-text-file
   "auto.master"
   "/shares " autofs-shares " --timeout 60 --browse\n"
   "/net nolock -hosts --timeout=60\n"))

(define (autofs:get)
  (+s shepherd-root autofs-daemon
      (list
       (shepherd-service
        (provision '(autofs automount))
        (requirement '(loopback file-systems))
        (start #~(make-forkexec-constructor
                  (list #$(file-append autofs "/sbin/automount")
                        "-f" #$autofs-config)))
        (stop #~(make-kill-destructor))))))
