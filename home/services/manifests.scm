(define-library (home services manifests)
  (export %manifests)

  (import (scheme base)
          (atlas home services manifests)
          (utils services))

  (begin
    (define %manifests
      (&s home-manifests #:config
          '(("browsing"
             "icecat")
            ("games"
             "xonotic"
             "supertuxkart"
             "supertux"
             "uqm")
            ("graphics"
             "krita"
             "inkscape"
             "gimp")
            ("tex"
             "texlive"))))))
