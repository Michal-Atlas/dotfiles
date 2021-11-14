(setq user-full-name "Michal Atlas"
  user-mail-address "michal.z.atlas@gmail.com")

(setq org-directory "~/Documents/")
(setq projectile-project-search-path (list "~/Documents" "~/source"))
(setq org-agenda-files "~/Documents/agenda.list")
(setq calendar-week-start-day 1)
(setq org-agenda-start-on-weekday 1)
(setq find-function-C-source-directory "~/source/emacs")
(setq rmh-elfeed-org-files (list "~/.elfeed.org"))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap 'use-package'
(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/use-package")
  (require 'use-package))

;; in ~/.doom.d/config.el
(setq doom-theme 'doom-monokai-classic)
(tool-bar-mode -1)
(menu-bar-mode -1)

(use-package format-all)
(add-hook 'prog-mode-hook 'format-all-mode)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-monokai-classic t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
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

(use-package company
  :config
  (company-mode)
  (add-hook 'after-init-hook 'global-company-mode))
(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

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

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (XXX-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package adaptive-wrap)
(use-package calfw)
(use-package calfw-org)
(use-package elfeed)
(use-package elfeed-org)
(use-package vimish-fold)
(use-package diff-hl)
(use-package diredfl)
(use-package dired-rsync)
(use-package ibuffer-projectile)
(use-package ibuffer-vc)
(use-package undo-tree)
(use-package git-timemachine)
(use-package mu4e-alert)
(use-package org-msg)
(use-package vterm)
(use-package quickrun)
(use-package magit)
(use-package magit-todos)
(use-package pdf-tools)
(use-package kurecolor)
(use-package ranger)
(use-package all-the-icons-dired)
(use-package crux)
(use-package xkcd)
(use-package git-gutter
  :config
  (global-git-gutter-mode +1))
(use-package org-fragtog
  :config
  (add-hook 'org-mode-hook 'org-fragtog-mode))
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
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package org-present)
(use-package ob-async)
(use-package org-cliplink)
(use-package org-superstar
  :hook (org-mode-hook . (lambda () (org-superstar-mode 1))))

(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(provide '.emacs)
;;; .emacs ends here
