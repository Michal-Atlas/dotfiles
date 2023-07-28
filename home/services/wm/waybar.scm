(define-library (home services wm waybar)
  (import (scheme base)
          (atlas utils services)
          (rde home services wm))
  (export %waybar)
  (begin
    (define %waybar
      (&s home-waybar
          (config
           #(((ipc . #t)
              (id . 0)
              (modules-left . #("sway/workspaces" "sway/mode"))
              (modules-center . #("sway/window"))
              (modules-right . #("idle_inhibitor" "pulseaudio" "network"
                                 "cpu" "memory" "disk" "backlight" "battery"
                                 "clock" "tray"))
              (idle_inhibitor . ((format . "{icon}")
                                 (format-icons . ((activated . "")
                                                  (deactivated . "")))))
              (disk . ((format . "{used}/{total}")))
              (tray . ((spacing . 10)))
              (pulseaudio . ((format . "{volume}% ")
                             (format-muted . "--% ")
                             (on-click . "swaymsg exec pavucontrol")))
              (network . ((format-wifi . "{essid} {ipaddr}/{cidr}")
                          (format-ethernet . "{ipaddr}/{cidr}")
                          (tooltip-format . "{signalStrength}%")))
              (clock . ((format . "{:%FT%TZ}")))
              (cpu . ((format . "{usage}% ")))
              (memory . ((format . "{}% ")))
              (battery . ((format . "{}% BAT")))
              (backlight . ((format . "{percent}% "))))))
          (style-css `((* ((font-size . 14px)
                           (font-family . "Fira Code")))
                       (window#waybar
                        ((background-color . #{rgba(0,0,0,0)}#)))
                       (label
                        ((background . #{#292b2e}#)
                         (color . #{#fdf6e3}#)
                         (margin . #{0 1px}#)
                         (border-radius . 5px)
                         (padding 0px 5px 0px 5px)
                         (border-left 2px solid grey)
                         (border-right 2px solid grey)))
                       (#{#workspaces}#
                        ((background . #{#1a1a1a}#)))
                       ((#{#workspaces}# button)
                        ((padding 0 2px)
                         (color . #{#fdf6e3}#)))
                       ((#{#workspaces}# button.focused)
                        ((color . #{#268bd2}#)))
                       (#{#pulseaudio}# ((color . #{#268bd2}#)))
                       (#{#memory}# ((color . #{#2aa198}#)))
                       (#{#cpu}# ((color . #{#6c71c4}#)))
                       (#{#battery}# ((color . #{#859900}#)))
                       (#{#disk}# ((color . #{#b58900}#)))))))))
