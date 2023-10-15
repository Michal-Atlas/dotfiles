(define-module (atlas config home services mcron)
  #:use-module (atlas combinators)
  #:use-module (guix gexp)
  #:use-module (gnu home services mcron)
  #:use-module (gnu packages base)
  #:use-module (gnu packages sync)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages linux))

(define-public %mcron
  (compose
   (maybe-service
    (const (string= (gethostname) "hydra"))
    (hm/+s home-mcron hydra-extensions
           (home-mcron-configuration
            (jobs
             (list #~(job "0 6 * * *"
                          (string-append
                           #$(file-append onedrive "/bin/onedrive")
                           " --synchronize")
                          "Onedrive")
                   #~(job "*/10 * * * *"
                          (string-append
                           #$(file-append procps "/bin/pgrep") " unison >/dev/null || "
                           #$(file-append unison "/bin/unison")
                           " -batch")
                          "Unison"))))))
   (hm/&s home-mcron
          (jobs
           (list
            #~(job "0 * * * *"
                   (string-append
                    #$(file-append findutils "/bin/find")
                    " ~/tmp/ ~/Downloads/ -mindepth 1 -mtime +2 -delete;")
                   "Clear tmpfiles")
            #~(job "0 * * * *"
	           "guix gc -F 20G"))))))
