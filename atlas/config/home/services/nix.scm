(define-module (atlas config home services nix)
  #:use-module (atlas combinators)
  #:use-module (atlas home services nix))

(define-public %nix
  (hm/&s home-nix #:config
         '(("github:NixOs/nixpkgs/bc9afe9f951b614523463f94e54b8714ba4e461d"
            "jetbrains.idea-ultimate"
            "discord"
            "spot"
            "telegram-desktop"
            "zotero"
            "insomnia"))))
