(define-library (home services mcron)
  (import (scheme base)
          (utils services)
          (guix gexp)
          (gnu home services mcron)
          (gnu packages base))
  (export %mcron)
  (begin
    (define (%mcron host)
      (&s home-mcron
          (jobs
           (@host host
                  #:hydra
                  #~(job "0 6 * * *"
	                 (string-append 
	                  #$(file-append onedrive "/bin/onedrive")
	                  " --synchronize"))
                  #~(job "0 * * * *"
	                 (string-append 
	                  #$(file-append findutils "/bin/find")
	                  " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -delete;"))
                  #~(job "0 * * * *"
	                 "guix gc -F 20G")))))))
