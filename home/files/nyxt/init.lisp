(define-configuration web-buffer
  ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))
(define-configuration browser
  ((theme theme:+dark-theme+)))
