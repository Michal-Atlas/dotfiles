(define-library (home packages gnome)
  (import (scheme base)
          (gnu packages gnome-xyz))
  (export %gnome-packages)
  (begin
    (define %gnome-packages
      (list
       gnome-shell-extension-vitals
       gnome-shell-extension-unite-shell
       gnome-shell-extension-vertical-overview
       gnome-shell-extension-clipboard-indicator
       gnome-shell-extension-topicons-redux
       gnome-shell-extension-radio
       gnome-shell-extension-paperwm
       gnome-shell-extension-hide-app-icon
       gnome-shell-extension-dash-to-panel
       gnome-shell-extension-appindicator
       gnome-shell-extension-customize-ibus
       gnome-shell-extension-transparent-window
       gnome-shell-extension-sound-output-device-chooser
       gnome-shell-extension-just-perfection
       gnome-shell-extension-gsconnect
       gnome-shell-extension-dash-to-dock
       gnome-shell-extension-burn-my-windows
       gnome-shell-extension-blur-my-shell
       gnome-shell-extension-jiggle
       gnome-shell-extension-noannoyance))))
