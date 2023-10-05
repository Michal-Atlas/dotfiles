(define-module (atlas config home services flatpak)
  #:use-module (atlas combinators)
  #:use-module (atlas home services flatpak))
  
(define-public %flatpak
  (hm/&s home-flatpak
         (packages
          '(("flathub"
             "com.discordapp.Discord"
             "com.felipekinoshita.Wildcard"
             "com.github.IsmaelMartinez.teams_for_linux"
             "com.github.tchx84.Flatseal"
             "com.spotify.Client"
             "org.geogebra.GeoGebra"
             "org.telegram.desktop"
             "org.zotero.Zotero"
             "rest.insomnia.Insomnia")))))
