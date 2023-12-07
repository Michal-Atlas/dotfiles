(define-module (home unison)
  #:use-module (atlas utils services)
  #:use-module (gnu home services)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services mcron)
  #:use-module (guix gexp)
  #:use-module (gnu packages ocaml)
  #:use-module (gnu packages linux)
  #:use-module (ice-9 curried-definitions)
  #:export (unison-get
            unison-remote))

(define unison-remote (make-parameter #f))

(define (unison-get)
  (+s home-files unison-files
      (let ((roots `("/home/michal_atlas"
                     ,(string-append "ssh://" (unison:remote) "//home/michal_atlas")))
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
                    (map (pref "path") paths))))))))
