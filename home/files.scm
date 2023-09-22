(define-library (home files)
  (import (scheme base)
          (atlas utils services)
          (guix gexp)
          (gnu packages video)
          (rde serializers ini)
          (gnu home services)
          (gnu packages terminals))
  (export %files)
  (begin
    (define (%files host)
      (+s home-files
          ;; local-file being explicit allows earlier check for file existence
          `((".emacs.d/init.el" ,(local-file "files/emacs.el"))
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

            (".guile" ,(local-file "files/guilerc"))
            (".inputrc" ,(local-file "files/inputrc"))
            (".sbclrc" ,(local-file "files/sbcl.lisp"))
            (".gtkrc-2.0" ,(local-file "files/gtk2.ini"))
            (".config/gtk-3.0/settings.ini" ,(local-file "files/gtk3.ini"))
            (".local/share/nyxt/bookmarks.lisp" ,(local-file "files/nyxt/bookmarks.lisp"))
            (".config/nyxt/config.lisp" ,(local-file "files/nyxt/init.lisp"))
            (".config/mpv/scripts/mpris.so"
             ,(file-append mpv-mpris "/lib/mpris.so")))))))
