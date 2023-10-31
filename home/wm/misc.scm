(define lock-wallpaper
  (file-fetch
   "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg"
   "oOYE1PZ1g2HvXqUbL5aE3xkW+SqkKPmO0GaVI9QlI40="))

(list
 (&s home-swayidle
     (config
      `((timeout 1200 "'swaymsg \"output * dpms off\"'"
                 resume "'swaymsg \"output * dpms on\"'")
        (before-sleep "'swaylock'"))))

 (&s home-swaylock
     (config
      `((color . "000000")
        ,#~(string-append "image=" #$lock-wallpaper))))

 (&s home-mako
     (sections
      (list
       (home-mako-section
        (default-timeout 10000)
        (max-visible 10))))))
