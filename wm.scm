(define-module (wm)
  #:use-module (engstrand wallpapers)
  #:use-module (rde features wm)
  #:use-module (rde features xdisorg)
  #:use-module (rde features linux)
  #:use-module (atlas utils download)
  #:use-module (guix gexp)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages python-xyz)
  #:export (wm))

(define wallpaper
  (get-wallpaper-path "space/astronaut-repair.jpg"))

(define lock-wallpaper
  (file-fetch
   "https://www.gnu.org/graphics/techy-gnu-tux-bivouac-large.jpg"
   "oOYE1PZ1g2HvXqUbL5aE3xkW+SqkKPmO0GaVI9QlI40="))

(define wm
  (list
   (feature-rofi #:theme "Arc-Dark")
   (feature-sway
    #:xwayland? #t
    #:extra-config
    `((input "1739:32382:DELL0740:00_06CB:7E7E_Touchpad"
             ((dwt enabled)
              (tap enabled)
              (natural_scroll enabled)
              (middle_emulation enabled)))
      (output "*" ((bg ,wallpaper fill)))
      (output "HDMI-A-1" ((position "1920,0")))
      (output "DP-1" ((position "0,0")))
      (exec ,(file-append xhost "/bin/xhost +si:localuser:root"))
      (exec ,(file-append i3-autotiling "/bin/autotiling"))))
   (feature-sway-run-on-tty)
   (feature-sway-screenshot)
   (feature-backlight)
   (feature-pipewire)
   (feature-swaylock
    #:extra-config
    `((color . "000000")
      ,#~(string-append "image=" #$lock-wallpaper)))
   (feature-swayidle
    #:lock-timeout 900)
   (feature-batsignal)
   (feature-swaynotificationcenter)
   (feature-waybar
    #:transitions? #t
    #:waybar-modules
    (list
     (waybar-sway-workspaces)
     (waybar-idle-inhibitor)
     (waybar-volume
      #:show-percentage? #t)
     (waybar-cpu)
     (waybar-memory)
     (waybar-disk)
     (waybar-disk
      #:name 'home
      #:path "/home/michal_atlas"
      #:disk-icon "⌂")
     (waybar-custom
      #:icon "𝖀"
      #:exec
      (program-file
       "unison-running-p"
       #~(begin
           (use-modules (json))
           (scm->json
            (let ((unison? (zero?
                            (system
                             #$(file-append
                                procps
                                "/bin/pgrep -x unison >/dev/null")))))
              `((text . ,(if unison? "✓" "✛"))
                (tooltip . ,(if unison? "connected" "disconnected"))))))))
     (waybar-battery
      #:intense? #t
      #:show-percentage? #t)
     (waybar-clock)
     (waybar-tray)))))
