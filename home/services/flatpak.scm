(define-library (home services flatpak)
  (import (scheme base)
          (utils services)
          (atlas home services flatpak))
  (export %flatpak)
  (begin
    (define %flatpak
      (&s home-flatpak
          (packages
           '(("flathub"
              "com.discordapp.Discord"
              "com.github.IsmaelMartinez.teams_for_linux"
              "com.spotify.Client"
              "com.usebottles.bottles"
              "com.visualstudio.code"
              "org.geogebra.GeoGebra"
              "org.openrgb.OpenRGB"
              "org.telegram.desktop"
              "org.zotero.Zotero"
              "rest.insomnia.Insomnia")))))))
