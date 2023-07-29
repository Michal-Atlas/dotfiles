(define-library (home files)
  (import (scheme base)
          (utils services)
          (guix gexp)
          (rde serializers ini)
          (gnu home services)
          (gnu packages terminals))
  (export %files)
  (begin
    (define rsync-dirs '("Sync" "cl" "Documents" "Zotero"))
    (define (rsync-target)
      (car (@host
            #:hydra "dagon.local"
            #:dagon "hydra.local")))

    (define (%files)
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
                                       "/share/foot/themes/monokai-pro"))))))))
            (".guile" ,(local-file "files/guilerc"))
            (".inputrc" ,(local-file "files/inputrc"))
            (".sbclrc" ,(local-file "files/sbcl.lisp"))
            (".local/share/nyxt/bookmarks.lisp" ,(local-file "files/nyxt/bookmarks.lisp"))
            (".config/nyxt/config.lisp" ,(local-file "files/nyxt/init.lisp"))
            (".unison/default.prf"
             ,(mixed-text-file "unison-profile"
                               "root=/home/michal_atlas\n"
                               "root=ssh://"
                               (rsync-target)
                               "//home/michal_atlas\n"                                  
                               "path=Sync\n"
                               "path=Documents\n"
                               "path=cl\n"
                               "path=Zotero\n"
                               "auto=true\n"
                               "log=true\n"
                               "sortbysize=true\n")))))))
