(define-module (atlas config home services wm)
  #:use-module (atlas config home services wm sway)
  #:use-module (atlas config home services wm waybar)
  #:use-module (atlas config home services wm misc))

(define-public %wm
  (compose
   %sway
   %waybar
   %misc))
