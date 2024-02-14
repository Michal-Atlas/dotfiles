(define-module (home files)
  #:use-module (atlas utils services)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)
  #:use-module (gnu home services)
  #:use-module (guix gexp)
  #:use-module (rde serializers ini)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages video)
  #:use-module (atlas utils download)
  #:use-module (gnu packages containers)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:export (files))

(define files
  (list
   (+s home-files dotfiles
       ;; local-file being explicit allows earlier check for file existence
       `((".guile" ,(local-file "../files/guilerc"))
         (".inputrc" ,(local-file "../files/inputrc"))
         (".gtkrc-2.0" ,(local-file "../files/gtk2.ini"))
         (".local/share/nyxt/bookmarks.lisp" ,(local-file "../files/nyxt/bookmarks.lisp"))
         (".face"
          ,(file-fetch
            "https://git.sr.ht/~michal_atlas/www/blob/0d74b8802a0c9e820c38e41cfe920f1bdbb06746/assets/mlxan/carcass-mountain/portraits/weeping-priest.jpeg"
            "1MnHsYKJpI/h8zJa01MtPjgf/UMtSLZQ7YWcslj1Xxc="))
         (".mozilla/native-messaging-hosts/com.github.browserpass.native.json"
          ,(file-append browserpass-native
                        "/lib/browserpass/hosts/firefox/com.github.browserpass.native.json"))
         (".bin/docker"
          ,(program-file "docker"
                         #~(apply execlp
                                  #$(file-append podman "/bin/podman")
                                  (command-line))))))))
