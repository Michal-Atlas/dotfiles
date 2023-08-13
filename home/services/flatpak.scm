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
              "com.felipekinoshita.Wildcard"
              "com.github.IsmaelMartinez.teams_for_linux"
              "com.github.johnfactotum.Foliate"
              "com.github.tchx84.Flatseal"
              "com.spotify.Client"
              "com.usebottles.bottles"
              "com.visualstudio.code"
              "de.haeckerfelix.Shortwave"
              "io.typora.Typora"
              "org.geogebra.GeoGebra"
              "org.ghidra_sre.Ghidra"
              "org.openrgb.OpenRGB"
              "org.telegram.desktop"
              "org.zotero.Zotero"
              "rest.insomnia.Insomnia")))))))
