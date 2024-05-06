(define-module (home services)
  #:use-module (atlas utils services)
  #:use-module (home files)
  #:use-module (home mcron)
  #:use-module (home packages)
  #:use-module (home pass)
  #:use-module (home ssh)
  #:use-module (home bash)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu home services syncthing)
  #:use-module (guix gexp)
  #:use-module (channels)
  #:use-module (rde home services bittorrent)
  #:use-module (rde home services i2p)
  #:use-module (home bash)
  #:use-module (home dconf)
  #:use-module (atlas home services bash)
  #:export (get-services))

(define (get-services)
  (cons*
   (&s home-i2pd)
   (+s home-environment-variables 'extend
       `(("BROWSER" . "firefox")
         ("MOZ_ENABLE_WAYLAND" . "1")
         ("MOZ_USE_XINPUT2" . "1")
         ("_JAVA_AWT_WM_NONREPARENTING" . "1")
         ("PATH" . "$PATH:$HOME/.bin/")
         ("GUIX_SANDBOX_HOME" . "$HOME/Games")
         ("BAT_THEME" . "ansi")
         ("HISTFILESIZE" . "-1")
         ("HISTCONROL" . "ignoredups")
         ("HISTSIZE" . "-1")
         ("XDG_DATA_DIRS" .
          "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share")
         ("XDG_DATA_DIRS" .
          "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share")
         ("PATH" .
          "$HOME/.local/share/flatpak/exports/bin:$PATH")))
   pass
   bash
   mcron
   ssh
   packages
   dconf
   (&s home-channels #:config %channels)
   (&s home-syncthing)
   files))
