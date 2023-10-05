(define-module (atlas config home services nyxt)
  #:use-module (atlas combinators)
  #:use-module (rde home services web-browsers))

(define-public %nyxt
  (hm/&s home-nyxt
         (config-lisp
          '((define-configuration web-buffer
              ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))
            (define-configuration browser
              ((theme theme:+dark-theme+)))))))
