(define-module (emacs)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (atlas packages emacs-xyz)
  #:use-module ((emacs packages melpa)
                #:select (emacs-shen-elisp))
  #:use-module (guixrus packages emacs)
  #:use-module (rde home services emacs)
  #:use-module (rde gexp)
  #:use-module (rde features emacs)
  #:use-module (rde features emacs-xyz)
  #:export (emacs))

(define elisp-packages
  (list
   emacs-ace-window
   emacs-adaptive-wrap
   emacs-anzu
   emacs-arei
   emacs-auctex
   emacs-avy
   emacs-bind-map
   emacs-browse-kill-ring
   emacs-calfw
   emacs-carp
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
   emacs-gemini-mode
   emacs-git-gutter
   emacs-go-mode
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
   emacs-nix-mode
   emacs-on-screen
   emacs-orderless
   emacs-org
   emacs-org-modern
   emacs-org-re-reveal
   emacs-org-roam
   emacs-org-superstar
   emacs-ox-gemini
   emacs-ox-reveal
   emacs-paredit
   emacs-password-generator
   emacs-password-store
   emacs-password-store-otp
   emacs-pdf-tools
   emacs-rainbow-delimiters
   emacs-rainbow-identifiers
   emacs-realgud
   emacs-rust-mode
   emacs-shen-elisp
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
   emacs-zerodark-theme))

(define emacs
  (list
   (feature-emacs
    #:default-application-launcher? #f
    #:additional-elisp-packages elisp-packages
    #:extra-init-el `(,(slurp-file-like (local-file "files/emacs.el"))))
   (feature-emacs-appearance)
   (feature-emacs-modus-themes
    #:dark? #t)
   (feature-emacs-which-key)
   (feature-emacs-all-the-icons)
   (feature-emacs-tramp)
   (feature-emacs-dired)
   (feature-emacs-eshell)
   (feature-emacs-re-builder)
   (feature-emacs-comint)
   (feature-emacs-shell)
   (feature-emacs-power-menu)
   (feature-emacs-completion)
   (feature-emacs-vertico)
   (feature-emacs-tempel)
   (feature-emacs-project)
   (feature-emacs-smartparens
    #:show-smartparens? #t)
   (feature-emacs-eglot)
   (feature-emacs-flymake)
   (feature-emacs-elisp)
   (feature-emacs-git)
   (feature-emacs-guix)
   (feature-emacs-xref)
   (feature-emacs-help)
   (feature-emacs-info)
   (feature-emacs-org)
   (feature-emacs-graphviz)
   (feature-emacs-elpher)
   (feature-emacs-nyxt)))
