(define-library (home services wm misc)
  (import (scheme base)
          (utils services)
          (rde home services wm)
          (guixrus home services mako))
  (export %misc)
  (begin
    (define %misc
      (macromap
       &s
       (home-swayidle
        (config
         `((timeout 1200 "'swaymsg \"output * dpms off\"'"
                    resume "'swaymsg \"output * dpms on\"'")
           (before-sleep "'swaylock'"))))

       (home-swaylock
        (config
         `((color . "000000"))))

       (home-mako
        (sections
         (list
          (home-mako-section
           (default-timeout 10000)
           (max-visible 10)))))))))
