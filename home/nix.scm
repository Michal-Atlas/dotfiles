(&s home-nix #:config
    (string-append
     (getenv "DOTFILE_ROOT")
     "/nix"))
