(define-module (home nyxt)
  #:use-module (atlas utils services)
  #:use-module (rde home services web-browsers)
  #:export (nyxt))

(define nyxt
 (&s home-nyxt
     (config-lisp
      '((define-configuration (web-buffer prompt-buffer panel-buffer
                                          nyxt/mode/editor:editor-buffer)
          ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))
        (define-configuration browser
          ((theme theme:+dark-theme+)))))))
