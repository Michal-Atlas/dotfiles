(define-library (home services wm)
  (import (scheme base)
          (guile)
          (home services wm sway)
          (home services wm waybar)
          (home services wm misc))
  (export %wm)
  (begin
    (define %wm
      (cons*
       %sway
       %waybar
       %misc))))
