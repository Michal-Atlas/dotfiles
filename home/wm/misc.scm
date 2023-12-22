(define-module (home wm misc)
  #:use-module (atlas utils download)
  #:use-module (atlas utils services)
  #:use-module (rde home services wm)
  #:use-module (guix gexp)
  #:use-module (guixrus home services mako)
  #:export (wm:misc))

(define lock-wallpaper
  (file-fetch
   "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg"
   "oOYE1PZ1g2HvXqUbL5aE3xkW+SqkKPmO0GaVI9QlI40="))

(define wm:misc
 (list
  (&s home-swayidle
      (config
       `((timeout 1200 "'swaymsg \"output * dpms off\"'"
                  resume "'swaymsg \"output * dpms on\"'")
         (before-sleep "'playerctl stop; swaylock'"))))

  (&s home-swaylock
      (config
       `((color . "000000")
         ,#~(string-append "image=" #$lock-wallpaper))))

  (&s home-mako
      (sections
       (list
        (home-mako-section
         (default-timeout 10000)
         (max-visible 10)))))))
