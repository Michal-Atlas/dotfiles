(define-module (atlas config home services wm misc)
  #:use-module (atlas combinators)
  #:use-module (rde home services wm)
  #:use-module (guixrus home services mako))

(define-public %misc
  (compose
   (hm/&s home-swayidle
          (config
           `((timeout 1200 "'swaymsg \"output * dpms off\"'"
                      resume "'swaymsg \"output * dpms on\"'")
             (before-sleep "'swaylock'"))))

   (hm/&s home-swaylock
          (config
           `((color . "000000"))))

   (hm/&s home-mako
          (sections
           (list
            (home-mako-section
             (default-timeout 10000)
             (max-visible 10)))))))
