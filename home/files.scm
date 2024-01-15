(define-module (home files)
  #:use-module (atlas utils services)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:use-module (rde serializers ini)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages video)
  #:use-module (atlas utils download)
  #:use-module (gnu packages containers)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:export (files))

(define (inferior)
  (inferior-for-channels
   (list (channel
          (name 'guix)
          (url "https://git.savannah.gnu.org/git/guix.git")
          (branch "rust-team")
          (commit
           "bbec79fd55ba8efe4cb015bd07e4f40fb7d252d1")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))))

(define files
  (list
   (+s home-files dotfiles
       ;; local-file being explicit allows earlier check for file existence
       `((".emacs.d/init.el" ,(local-file "../files/emacs.el"))
         (".guile" ,(local-file "../files/guilerc"))
         (".sbclrc" ,(plain-file "sbclrc" "(load #p\"~/.sbclrc.lisp\")"))
         (".inputrc" ,(local-file "../files/inputrc"))
         (".gtkrc-2.0" ,(local-file "../files/gtk2.ini"))
         (".local/share/nyxt/bookmarks.lisp" ,(local-file "../files/nyxt/bookmarks.lisp"))
         (".face"
          ,(file-fetch
            "https://git.sr.ht/~michal_atlas/www/blob/0d74b8802a0c9e820c38e41cfe920f1bdbb06746/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg"
            "1MnHsYKJpI/h8zJa01MtPjgf/UMtSLZQ7YWcslj1Xxc="))
         (".bin/docker"
          ,(program-file "docker"
                         #~(apply execlp
                                  #$(file-append podman "/bin/podman")
                                  (command-line))))))
   (+s home-xdg-configuration dotfiles
       `(("foot/foot.ini"
          ,(apply mixed-text-file "foot.ini"
                  (serialize-ini-config
                   `((main
                      ((font . #{Fira Code:size=12}#)
                       (pad . #{5x5 center}#)
                       (term . xterm-256color)
                       (include . ,(file-append
                                    foot
                                    "/share/foot/themes/monokai-pro"))))
                     (colors
                      ((alpha . 0.9)))))))
           ("mpv/scripts/mpris.so"
            ,(file-append
              (car (lookup-inferior-packages
                    (inferior)
                    "mpv-mpris"))
              "/lib/mpris.so"))))))
