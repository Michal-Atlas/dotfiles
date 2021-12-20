;; Variable Init

;; [[file:../dotfiles/conf.org::*Variable Init][Variable Init:1]]
(setq user-full-name "Michal Atlas"
      user-mail-address "michal.z.atlas@gmail.com")

(setq org-directory "~/Documents/")
(setq projectile-project-search-path (list "~/Documents" "~/source"))
(setq org-agenda-files "~/Documents/agenda.list")
(setq calendar-week-start-day 1)
(setq org-agenda-start-on-weekday 1)
(setq find-function-C-source-directory "~/source/emacs")
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 10 60) 'recentf-save-list)
;; Variable Init:1 ends here

;; Package Bootstrap

;; [[file:../dotfiles/conf.org::*Package Bootstrap][Package Bootstrap:1]]
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; Package Bootstrap:1 ends here

;; Quelpa

;; [[file:../dotfiles/conf.org::*Quelpa][Quelpa:1]]
(setq quelpa-build-explicit-tar-format-p t)
      (unless (package-installed-p 'quelpa)
	(with-temp-buffer
	  (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
	  (eval-buffer)
	  (quelpa-self-upgrade)))
      ;; Install and load `quelpa-use-package'.
      (quelpa
       '(quelpa-use-package
	 :fetcher git
	 :url "https://github.com/quelpa/quelpa-use-package.git"))
      (require 'quelpa-use-package)
      (quelpa-use-package-activate-advice)
;; Quelpa:1 ends here

;; Use-Package

;; [[file:../dotfiles/conf.org::*Use-Package][Use-Package:1]]
(require 'bind-key)
(setq use-package-always-ensure t)

(require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (use-package auto-package-update
    :config
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe))
;; Use-Package:1 ends here

;; Built-in Keybinds

;; [[file:../dotfiles/conf.org::*Built-in Keybinds][Built-in Keybinds:1]]

;; Built-in Keybinds:1 ends here

;; Dashboard

;; [[file:../dotfiles/conf.org::*Dashboard][Dashboard:1]]
(use-package dashboard
  :config
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-items '((recents  . 7)
			  (bookmarks . 5)
			  (projects . 7)
			  (agenda . 5)
			  (registers . 5)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-banner-logo-title "Atlas Emacs")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-set-init-info t)
  (setq dashboard-week-agenda t)
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook))
;; Dashboard:1 ends here

;; Theming

;; [[file:../dotfiles/conf.org::*Theming][Theming:1]]
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)

(use-package indent-guide
  :hook (prog-mode . indent-guide-global-mode))
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(set-frame-font "Jetbrains Mono-10" nil t)
(add-to-list 'default-frame-alist '(font . "Jetbrains Mono-10"))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-gruvbox t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-gruvbox") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(use-package solaire-mode)
(solaire-global-mode +1)

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-popup-type 'minibuffer))

(use-package company-box
  :hook (company-mode . company-box-mode))

(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package rainbow-blocks
  :hook ((lisp-mode . rainbow-blocks-mode)
	 (emacs-lisp-mode . rainbow-blocks-mode)))
;; Theming:1 ends here

;; Formatting

;; [[file:../dotfiles/conf.org::*Formatting][Formatting:1]]
(use-package format-all
  :hook (prog-mode . format-all-ensure-formatter))
(use-package aggressive-indent
  :config (global-aggressive-indent-mode 1))
;; Formatting:1 ends here

;; Crux

;; [[file:../dotfiles/conf.org::*Crux][Crux:1]]
(use-package crux)
;; Crux:1 ends here

;; Undo-tree

;; [[file:../dotfiles/conf.org::*Undo-tree][Undo-tree:1]]
(use-package undo-tree
  :config (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))
;; Undo-tree:1 ends here

;; Company

;; [[file:../dotfiles/conf.org::*Company][Company:1]]
(use-package company
  :config
  (company-mode)
  :hook
  (after-init . global-company-mode))
(use-package flycheck
  :config
  (global-flycheck-mode))
;; Company:1 ends here

;; Snippets

;; [[file:../dotfiles/conf.org::*Snippets][Snippets:1]]
(use-package yasnippet
  :config (yas-global-mode 1))
;; Snippets:1 ends here

;; Projectile

;; [[file:../dotfiles/conf.org::*Projectile][Projectile:1]]
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
;; Projectile:1 ends here

;; Treemacs

;; [[file:../dotfiles/conf.org::*Treemacs][Treemacs:1]]
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window)
	("C-x t 1"   . treemacs-delete-other-windows)
	("C-x t t"   . treemacs)
	("C-x t B"   . treemacs-bookmark)
	("C-x t C-t" . treemacs-find-file)
	("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))
;; Treemacs:1 ends here

;; Vertico

;; [[file:../dotfiles/conf.org::*Vertico][Vertico:1]]
;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Optionally use the `orderless' completion style. See
;; `+orderless-dispatch' in the Consult wiki for an advanced Orderless style
;; dispatcher. Additionally enable `partial-completion' for file path
;; expansion. `partial-completion' is important for wildcard support.
;; Multiple files can be opened at once with `find-file' if you enter a
;; wildcard. You may also give the `initials' completion style a try.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; Alternatively try `consult-completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
;; Vertico:1 ends here

;; LSP

;; [[file:../dotfiles/conf.org::*LSP][LSP:1]]
(global-set-key (kbd "C-c c") 'compile)
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; LSP:1 ends here

;; Magit

;; [[file:../dotfiles/conf.org::*Magit][Magit:1]]
(use-package magit
  :bind (
	("C-c v s" . magit-stage)
	("C-c v p" . magit-push)
	("C-c v f" . magit-pull)
	("C-c v c" . magit-commit)
	))
(use-package magit-todos)
;; Magit:1 ends here

;; Bongo

;; [[file:../dotfiles/conf.org::*Bongo][Bongo:1]]
(use-package bongo
  :ensure t)
;; Bongo:1 ends here

;; Resize Window

;; [[file:../dotfiles/conf.org::*Resize Window][Resize Window:1]]
(use-package resize-window
  :ensure t
  :bind ("C-S-r" . resize-window))
;; Resize Window:1 ends here

;; Misc.

;; [[file:../dotfiles/conf.org::*Misc.][Misc.:1]]
(use-package guix)
(use-package adaptive-wrap)
(use-package calfw)
(use-package calfw-cal)
(use-package calfw-org)
(use-package vimish-fold)
(use-package diff-hl)
(use-package diredfl)
(use-package dired-rsync)
(use-package ibuffer-projectile)
(use-package ibuffer-vc)
(use-package git-timemachine)
(use-package quickrun)
(use-package pdf-tools)
(use-package kurecolor)
(use-package ranger)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
(use-package crux)
(use-package xkcd)
(use-package htmlize
  :quelpa (htmlize :fetcher github :repo "hniksic/emacs-htmlize"))
(use-package git-gutter
  :config
  (global-git-gutter-mode +1))
(use-package org-fragtog
  :hook (org-mode . org-fragtog-mode))
(use-package avy
  :bind
  ("M-q" . avy-goto-word-0))
(use-package anzu
  :config
  ;; ANZU - Replace Highlighting
  (global-anzu-mode +1)
  :bind
  (("M-%" . anzu-query-replace)
   ("C-M-%" . anzu-query-replace-regexp)))
;; Misc.:1 ends here

;; Org Mode

;; [[file:../dotfiles/conf.org::*Org Mode][Org Mode:1]]
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (dot . t)
   (C . t)
   (shell . t)
   ))

(use-package org-present)
(use-package ob-async)
(use-package org-cliplink)
(use-package org-superstar
  :hook (org-mode . org-superstar-mode))
;; Org Mode:1 ends here

;; Marginalia

;; [[file:../dotfiles/conf.org::*Marginalia][Marginalia:1]]
;; Enable richer annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  ;;:bind (("M-A" . marginalia-cycle)
  ;;       :map minibuffer-local-map
  ;;       ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))
(use-package all-the-icons-completion
  :hook (marginalia-mode . all-the-icons-completion-mode))
;; Marginalia:1 ends here

;; Embark and Consult

;; [[file:../dotfiles/conf.org::*Embark and Consult][Embark and Consult:1]]
(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
		 nil
		 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
	 ("C-c h" . consult-history)
	 ("C-c m" . consult-mode-command)
	 ("C-c b" . consult-bookmark)
	 ("C-c k" . consult-kmacro)
	 ;; C-x bindings (ctl-x-map)
	 ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
	 ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
	 ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
	 ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
	 ;; Custom M-# bindings for fast register access
	 ("M-#" . consult-register-load)
	 ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
	 ("C-M-#" . consult-register)
	 ;; Other custom bindings
	 ("M-y" . consult-yank-pop)                ;; orig. yank-pop
	 ("<help> a" . consult-apropos)            ;; orig. apropos-command
	 ;; M-g bindings (goto-map)
	 ("M-g e" . consult-compile-error)
	 ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
	 ("M-g g" . consult-goto-line)             ;; orig. goto-line
	 ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
	 ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
	 ("M-g m" . consult-mark)
	 ("M-g k" . consult-global-mark)
	 ("M-g i" . consult-imenu)
	 ("M-g I" . consult-imenu-multi)
	 ;; M-s bindings (search-map)
	 ("M-s f" . consult-find)
	 ("M-s F" . consult-locate)
	 ("M-s g" . consult-grep)
	 ("M-s G" . consult-git-grep)
	 ("M-s r" . consult-ripgrep)
	 ("M-s l" . consult-line)
	 ("M-s L" . consult-line-multi)
	 ("M-s m" . consult-multi-occur)
	 ("M-s k" . consult-keep-lines)
	 ("M-s u" . consult-focus-lines)
	 ;; Isearch integration
	 ("M-s e" . consult-isearch-history)
	 :map isearch-mode-map
	 ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
	 ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
	 ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
	 ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer.
  ;; This is relevant when you use the default completion UI,
  ;; and not necessary for Vertico, Selectrum, etc.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0
	register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Optionally replace `completing-read-multiple' with an enhanced version.
  (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-file consult--source-project-file consult--source-bookmark
   :preview-key (kbd "M-."))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; Optionally configure a function which returns the project root directory.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (project-roots)
  (setq consult-project-root-function
	(lambda ()
	  (when-let (project (project-current))
	    (car (project-roots project)))))
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-root-function #'projectile-project-root)
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-root-function #'vc-root-dir)
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-root-function (lambda () (locate-dominating-file "." ".git")))
)
;; Embark and Consult:1 ends here

;; C

;; [[file:../dotfiles/conf.org::*C][C:1]]
(use-package irony
  :hook ((c-mode . irony-mode)
	 (c-mode . lsp)
	 (c++-mode . irony-mode)
	 (c++-mode . lsp)
	 (irony-mode . irony-cdb-autosetup-compile-options)))
(use-package irony-eldoc
  :hook (irony-mode . irony-eldoc))
;; C:1 ends here

;; Bash

;; [[file:../dotfiles/conf.org::*Bash][Bash:1]]
(add-hook 'shell-script-mode 'prog-mode)
;; Bash:1 ends here

;; Haskell

;; [[file:../dotfiles/conf.org::*Haskell][Haskell:1]]
(use-package lsp-haskell
  :hook ((haskell-mode . lsp)
	 (haskell-literate-mode . lsp)))
;; Haskell:1 ends here

;; Python

;; [[file:../dotfiles/conf.org::*Python][Python:1]]
(use-package lsp-pyright
  :hook (python-mode . lsp))
(use-package jedi
  :hook (python-mode . jedi:setup))
;; Python:1 ends here

;; Clojure

;; [[file:../dotfiles/conf.org::*Clojure][Clojure:1]]
(use-package clojure-mode
  :ensure t
  :hook (clojure-mode . prog-mode))
(use-package cider
  :ensure t
  :hook (clojure-mode . cider))
;; Clojure:1 ends here

;; Scala

;; [[file:../dotfiles/conf.org::*Scala][Scala:1]]
(use-package lsp-metals
  :ensure t
  :custom
  ;; Metals claims to support range formatting by default but it supports range
  ;; formatting of multiline strings only. You might want to disable it so that
  ;; emacs can use indentation provided by scala-mode.
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  :hook (scala-mode . lsp))
;; Scala:1 ends here

;; LaTeX

;; [[file:../dotfiles/conf.org::*LaTeX][LaTeX:1]]
(use-package lsp-latex
  :hook (latex-mode . prog-mode))
;; LaTeX:1 ends here

;; Hackles

;; [[file:../dotfiles/conf.org::*Hackles][Hackles:1]]
(use-package hackles
  :quelpa (hackles :fetcher github :repo "Michal-Atlas/emacs-hackles"))
;; Hackles:1 ends here

;; Elfeed
;; :PROPERTIES:
;; :HEADER-ARGS+: :tangle ~/.emacs.d/init.el
;; :END:

;; [[file:../dotfiles/conf.org::*Elfeed][Elfeed:1]]
(use-package elfeed)
(setq elfeed-feeds
      '(("https://xkcd.com/rss.xml" comics)
	("https://www.smbc-comics.com/comic/rss" comics)
	("https://www.giantitp.com/comics/oots.rss" comics)
	("https://feeds.feedburner.com/LookingForGroup" comics)
	("https://www.oglaf.com/" comics)
	("http://phdcomics.com/gradfeed.php" comics)
	("https://blog.tecosaur.com/tmio/rss.xml" emacs)
	("https://akce.cvut.cz/?node=rss&group=7" ctu)
	("https://akce.cvut.cz/?node=rss&group=11" ctu)
	("https://aktualne.cvut.cz/rss/newsflashes" ctu)
	("http://festivalofthespokennerd.libsyn.com/rss" podcast)
	("https://konfery.cz/rss/")
	("https://guix.gnu.org/feeds/blog.atom")))
;; Elfeed:1 ends here
