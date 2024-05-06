(define-library (home packages lisp)
  (import (scheme base)
          (gnu packages lisp)
          (gnu packages lisp-xyz))
  (export %lisp-packages)
  (begin
    (define %lisp-packages
      (list
       sbcl
       sbcl-alexandria
       sbcl-cffi
       sbcl-cl-yacc
       sbcl-clingon
       sbcl-coalton
       sbcl-iterate
       sbcl-linedit
       sbcl-log4cl
       sbcl-lparallel
       sbcl-mcclim
       sbcl-parenscript
       sbcl-s-xml
       sbcl-screamer
       sbcl-serapeum
       sbcl-series
       sbcl-tailrec
       sbcl-tar
       sbcl-terminal-keypress
       sbcl-terminal-size
       sbcl-terminfo
       sbcl-trees
       sbcl-trial
       sbcl-unix-opts
       sbcl-unix-opts))))
