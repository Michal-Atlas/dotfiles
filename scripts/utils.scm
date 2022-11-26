(define-module (scripts utils)
  #:use-module (srfi srfi-98)
  #:export (home channel-lock-file dotfile-dir home-config base-config))

(define home (get-environment-variable "HOME"))
(define channel-lock-file (string-append home "/dotfiles/channels.lock"))
(define dotfile-dir (string-append home "/dotfiles"))
(define home-config (string-append home "/dotfiles/atlas/home/home.scm"))
(define base-config (string-append home "/dotfiles/atlas/system/base.scm"))
