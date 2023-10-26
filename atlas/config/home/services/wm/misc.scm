(define-module (atlas config home services wm misc)
  #:use-module (atlas combinators)
  #:use-module (atlas utils download)
  #:use-module (guix gexp)
  #:use-module (rde home services wm)
  #:use-module (guixrus home services mako))

(define lock-wallpaper
  (file-fetch
   "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg"
   "oOYE1PZ1g2HvXqUbL5aE3xkW+SqkKPmO0GaVI9QlI40="))

(define-public %misc
  (compose
   (hm/&s home-swayidle
          (config
           `((timeout 1200 "'swaymsg \"output * dpms off\"'"
                      resume "'swaymsg \"output * dpms on\"'")
             (before-sleep "'swaylock'"))))

   (hm/&s home-swaylock
          (config
           `((color . "000000")
             ,#~(string-append "image=" #$lock-wallpaper))))

   (hm/&s home-mako
          (sections
           (list
            (home-mako-section
             (default-timeout 10000)
             (max-visible 10)))))))
