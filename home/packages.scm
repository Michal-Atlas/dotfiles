(define-module (home packages)
  #:use-module (gnu packages)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 textual-ports)
  #:use-module (gnu home services)
  #:use-module (atlas utils services)
  #:export (packages))

(define package-file (string-append (getenv "DOTFILE_ROOT") "/packages"))

(define packages
  (+s home-profile system-packages
      (map specification->package+output
           (filter
            (negate (cut string-prefix? ";" <>))
            (string-split
             (string-trim-both
              (call-with-input-file package-file
                get-string-all))
             #\newline)))))
