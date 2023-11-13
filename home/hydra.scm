(define-module (home hydra)
  #:use-module (ice-9 curried-definitions)
  #:use-module (atlas utils services)
  #:use-module (home hydra spotifyd)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu home services mcron)
  #:use-module (gnu packages sync)
  #:use-module (gnu packages linux)
  #:export (hydra:services))

(define (hydra:services)
  (list
   (hydra:spotifyd)
   (+s home-files unison
       (let ((roots '("/home/michal_atlas"
                      "ssh://dagon.local//home/michal_atlas"))
             (paths '("Sync"
                      "Documents"
                      "cl"
                      "Zotero"
                      "Pictures"
                      "Music"
                      ".password-store")))
         (define ((pref p) s)
           (string-append p "=" s "\n"))

         `((".unison/default.prf"
            ,(apply mixed-text-file "default.prf"
                    "auto=true\n"
                    "log=true\n"
                    "sortbysize=true\n"
                    "servercmd=" unison "/bin/unison\n"
                    (append
                     (map (pref "root") roots)
                     (map (pref "path") paths)))))))
   (+s home-mcron hydra-extensions
       (list #~(job "0 6 * * *"
                    (string-append
                     #$(file-append onedrive "/bin/onedrive")
                     " --synchronize")
                    "Onedrive")
             #~(job "*/10 * * * *"
                    (string-append
                     #$(file-append procps "/bin/pgrep") " unison >/dev/null || "
                     #$(file-append unison "/bin/unison")
                     " -batch -repeat=watch")
                    "Unison")))))
