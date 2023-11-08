(define-module (home files)
  #:use-module (atlas utils services)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:use-module (rde serializers ini)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages video)
  #:use-module (atlas utils download)
  #:use-module (gnu packages containers)
  #:export (files))

(define files
 (+s home-files dotfiles
     ;; local-file being explicit allows earlier check for file existence
     `((".emacs.d/init.el" ,(local-file "../files/emacs.el"))
       (".config/foot/foot.ini"
        ,(apply mixed-text-file "foot.ini"
                (serialize-ini-config
                 `((main
                    ((font . #{Fira Code:size=12}#)
                     (pad . #{5x5 center}#)
                     (include . ,(file-append
                                  foot
                                  "/share/foot/themes/monokai-pro"))))
                   (colors
                    ((alpha . 0.9)))))))

       (".guile" ,(local-file "../files/guilerc"))
       (".sbclrc" ,(plain-file "sbclrc" "(load #p\"~/.sbclrc.lisp\")"))
       (".inputrc" ,(local-file "../files/inputrc"))
       (".gtkrc-2.0" ,(local-file "../files/gtk2.ini"))
       (".local/share/nyxt/bookmarks.lisp" ,(local-file "../files/nyxt/bookmarks.lisp"))
       (".config/mpv/scripts/mpris.so"
        ,(file-append mpv-mpris "/lib/mpris.so"))
       (".face"
        ,(file-fetch
          "https://git.sr.ht/~michal_atlas/www/blob/0d74b8802a0c9e820c38e41cfe920f1bdbb06746/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg"
          "1MnHsYKJpI/h8zJa01MtPjgf/UMtSLZQ7YWcslj1Xxc="))
       (".bin/pp"
        ,(program-file "pp"
                       #~(begin
                           (use-modules (ice-9 pretty-print))

                           (call-with-input-file (cadr (command-line))
                             (lambda (f)
                               (let loop ((r (read f)))
                                 (unless (eof-object? r)
                                   (pretty-print r)
                                   (loop (read f)))))))))
       (".bin/docker"
        ,(program-file "docker"
                       #~(apply execlp
                                #$(file-append podman "/bin/podman")
                                (command-line)))))))
