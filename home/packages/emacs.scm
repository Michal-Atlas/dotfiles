(define-library (home packages emacs)
  (import (scheme base)
          (gnu packages emacs)
          (gnu packages emacs-xyz)
          (atlas packages emacs-xyz)
          (guixrus packages emacs)
          (nongnu packages emacs))
  (export %emacs-packages)
  (begin
    (define %emacs-packages
      (list      
       emacs-ace-window
       emacs-adaptive-wrap
       emacs-all-the-icons
       emacs-all-the-icons-dired
       emacs-anzu
       emacs-auctex
       emacs-avy
       emacs-bind-map
       emacs-browse-kill-ring
       emacs-calfw
       emacs-cheat-sh
       emacs-circe
       emacs-company
       emacs-consult
       emacs-consult-org-roam
       emacs-consult-yasnippet
       emacs-crux
       emacs-csv
       emacs-csv-mode
       emacs-dashboard
       emacs-debbugs
       emacs-direnv
       emacs-dmenu
       emacs-docker
       emacs-dockerfile-mode
       emacs-doom-modeline
       emacs-eat
       emacs-ediprolog
       emacs-eglot
       emacs-elfeed
       emacs-elpher
       emacs-embark
       emacs-ement
       emacs-engrave-faces
       emacs-eshell-did-you-mean
       emacs-eshell-prompt-extras
       emacs-eshell-syntax-highlighting
       emacs-eshell-vterm
       emacs-fish-completion
       emacs-flycheck
       emacs-flycheck-haskell
       emacs-gdscript-mode
       emacs-geiser
       emacs-geiser-guile
       emacs-gemini-mode
       emacs-git-gutter
       emacs-go-mode
       emacs-guix
       emacs-hackles
       emacs-haskell-mode
       emacs-highlight-indentation
       emacs-htmlize
       emacs-hydra
       emacs-iedit
       emacs-magit
       emacs-marginalia
       emacs-markdown-mode
       emacs-monokai-theme
       emacs-multi-term
       emacs-multiple-cursors
       emacs-next-pgtk
       emacs-nix-mode
       emacs-on-screen
       emacs-orderless
       emacs-org
       emacs-org-modern
       emacs-org-roam
       emacs-org-roam-ui
       emacs-org-superstar
       emacs-ox-gemini
       emacs-paredit
       emacs-password-generator
       emacs-password-store
       emacs-password-store-otp
       emacs-pdf-tools
       emacs-rainbow-delimiters
       emacs-rainbow-identifiers
       emacs-realgud
       emacs-rust-mode
       emacs-sly
       emacs-ssh-agency
       emacs-stumpwm-mode
       emacs-swiper
       emacs-tldr
       emacs-undo-tree
       emacs-vertico
       emacs-which-key
       emacs-yaml-mode
       emacs-yasnippet
       emacs-yasnippet-snippets
       emacs-zerodark-theme))))
