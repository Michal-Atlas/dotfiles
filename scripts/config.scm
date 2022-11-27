(define-module (scripts config))

(define-public user "michal_atlas")
(define-public host (vector-ref (uname) 1))

(define-public home (string-append "/home/" user))

(define-public channel-lock-file (string-append home "/dotfiles/channels.lock"))
(define-public dotfile-dir (string-append home "/dotfiles"))
(define-public home-config (string-append home "/dotfiles/atlas/home/home.scm"))
(define-public system-config (string-append home "/dotfiles/atlas/system.scm"))
