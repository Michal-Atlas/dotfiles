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
            ("fonts"
             "font-adobe-source-han-sans"
             "font-adobe-source-han-sans"
             "font-awesome"
             "font-dejavu"
             "font-fira-code"
             "font-ghostscript"
             "font-gnu-freefont"
             "font-jetbrains-mono"
             "font-sil-charis"
             "font-tamzen"
             "font-wqy-microhei"
             "font-wqy-zenhei"
             "font-wqy-zenhei"
             "fontconfig")
            ("games"
             "xonotic"
             "supertuxkart"
             "supertux"
             "uqm")
            ("graphics"
             "krita"
             "inkscape"
             "gimp")
            ("lisp"
             "sbcl"
             "sbcl-alexandria"
             "sbcl-cffi"
             "sbcl-cl-yacc"
             "sbcl-coalton"
             "sbcl-linedit"
             "sbcl-lparallel"
             "sbcl-mcclim"
             "sbcl-parenscript"
             "sbcl-s-xml"
             "sbcl-serapeum"
             "sbcl-series"
             "sbcl-tailrec"
             "sbcl-tar"
             "sbcl-terminal-keypress"
             "sbcl-terminal-size"
             "sbcl-terminfo"
             "sbcl-trees"
             "sbcl-trial"
             "sbcl-unix-opts")
            ("texlive"
             "texlive-scheme-basic"
             "texlive-tcolorbox"))))))
