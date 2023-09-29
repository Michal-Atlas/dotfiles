(define-module (home services nyxt)
  #:use-module (atlas utils services)
  #:use-module (rde home services web-browsers))

(define-public %nyxt
  (&s home-nyxt
      (config-lisp
       '((define-configuration web-buffer
           ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))
         (define-configuration browser
           ((theme theme:+dark-theme+)))))))
