(define-module (home hydra unison)
  #:use-module (atlas utils services)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services mcron)
  #:use-module (guix gexp)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages linux)
  #:use-module (ice-9 curried-definitions)
  #:export (hydra:unison:get))


(define (hydra:unison:get)
  (list
   (+s home-mcron unison-mcron
       (list
        #~(job "*/10 * * * *"
               (lambda ()
                 (if (zero? (system*
                             #$(file-append procps "/bin/pgrep")
                             "-x" "unison"))
                     (system* #$(file-append unison "/bin/unison")))
                 " -batch -repeat=watch")
               "Unison")))
   (+s home-files unison-files
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
                     (map (pref "path") paths)))))))))
