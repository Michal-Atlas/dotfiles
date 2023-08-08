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
       sbcl-coalton
       sbcl-linedit
       sbcl-lparallel
       sbcl-mcclim
       sbcl-parenscript
       sbcl-s-xml
       sbcl-serapeum
       sbcl-series
       sbcl-tailrec
       sbcl-tar
       sbcl-terminal-keypress
       sbcl-terminal-size
       sbcl-terminfo
       sbcl-trees
       sbcl-trial
       sbcl-unix-opts))))
