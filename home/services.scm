(define-module (home services)
  #:use-module (atlas utils services)
  #:use-module (home files)
  #:use-module (home mcron)
  #:use-module (home packages)
  #:use-module (home pass)
  #:use-module (home ssh)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (channels)
  #:use-module (rde home services bittorrent)
  #:use-module (rde home services i2p)
  #:use-module (atlas home services flatpak)
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
         ("HISTSIZE" . "-1")))
   pass
   mcron
   (&s home-flatpak
       (packages
        `(("flathub"
           "com.sindresorhus.Caprine"
           "com.discordapp.Discord"
           "com.github.IsmaelMartinez.teams_for_linux"
           "org.zotero.Zotero"
           "im.riot.Riot"
           "net.ankiweb.Anki"
           "com.github.tchx84.Flatseal"))))
   ssh
   packages
   (&s home-channels #:config %channels)
   files))
