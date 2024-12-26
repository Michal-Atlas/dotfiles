(use-package
  bind-key
  :config
  (add-to-list 'same-window-buffer-names "*Personal Keybindings*"))

(use-package hydra)

;;;; * Org-mode

(use-package org-modern :hook (org-mode . org-modern-mode))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (scheme . t)
   (lisp . t)
   (octave . t)
   (dot . t)
   (latex . t)))

(setq org-latex-default-packages-alist
      (cl-substitute-if
       '("colorlinks=true" "hyperref" nil)
       (lambda (entry) (string-equal (cl-second entry) "hyperref"))
       org-latex-default-packages-alist))

;;;; * Variable Init

(setq
 user-full-name "Michal Atlas"
 user-mail-address "michal_atlas+emacs@posteo.net")

(setq mastodon-instance-url "https://lgbtcz.social")
(setq mastodon-active-user "michal_atlas")
(setq-default indent-tabs-mode nil)

(setq backup-directory-alist '((".*" . "~/.local/state/emacs/bkp")))
(setq projectile-project-search-path (list "~/cl"))
(setq org-roam-directory "/home/michal_atlas/Documents/roam")
(setq enable-local-variables :all)
(setq calendar-week-start-day 1)
(setq org-agenda-start-on-weekday 1)
(setq find-function-C-source-directory "~/cl/emacs")
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq visible-bell t)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(run-at-time nil (* 10 60) 'recentf-save-list)
(global-prettify-symbols-mode +1)

(defun yes-or-no-p (prompt)
  (y-or-n-p prompt))
					;(dired-async-mode 1)
(setq auth-sources '("~/.authinfo.gpg"))

;;;; * WindMove

(windmove-default-keybindings)
(global-set-key (kbd "s-<up>") #'windmove-swap-states-up)
(global-set-key (kbd "s-<down>") #'windmove-swap-states-down)
(global-set-key (kbd "s-<left>") #'windmove-swap-states-left)
(global-set-key (kbd "s-<right>") #'windmove-swap-states-right)

;;;; * Theming

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)
(display-battery-mode 1)
(setq display-time-24hr-format t)
(display-time-mode 1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(use-package
  highlight-indentation
  :hook (prog-mode . highlight-indentation-mode)
  :custom (highlight-indent-guides-method 'bitmap))

(defvar font-code "Fira Code 12")
(set-frame-font font-code nil t)
(add-to-list 'default-frame-alist `(font . ,font-code))
(use-package fira-code-mode :config (global-fira-code-mode t))

(use-package
  highlight-indentation
  :hook (prog-mode . highlight-indentation-mode)
  :custom (highlight-indent-guides-method 'bitmap))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(use-package direnv :config (direnv-mode t))

;;;; * Theme

;;;; ** Monokai

; (use-package monokai-theme :config (load-theme 'monokai t))

;;;; * Modeline

(use-package doom-modeline :config (doom-modeline-mode 1))

;;;; * Completion

(global-set-key [remap dabbrev-expand] 'hippie-expand)

;;;; * Packages

(use-package
  rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))
(use-package
  rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-default 'preview-scale-function 1.5)

(repeat-mode 1)

(use-package
  undo-tree
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist
	'(("." . "~/.local/state/emacs/undo"))))

(use-package ace-window :bind ("M-o" . ace-window))

;;;; * Eshell

(use-package
  eshell-prompt-extras
  :config
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq
     eshell-highlight-prompt nil
     eshell-prompt-function 'epe-theme-lambda)))

(defun eshell-new ()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))


(add-hook
 'eshell-mode-hook
 (defun my-eshell-mode-hook ()
   (require 'eshell-z)))

(require 'eshell)
(use-package
  eshell-syntax-highlighting
  :config (eshell-syntax-highlighting-global-mode 1))
(setq eshell-review-quick-commands nil)
(require 'esh-module) ; require modules
(add-to-list 'eshell-modules-list 'eshell-tramp)
;; (use-package
;;  esh-autosuggest
;;  :hook (eshell-mode . esh-autosuggest-mode))

(use-package eat)
(use-package eshell-fringe-status)
(use-package eshell-vterm)
(use-package eshell-info-banner)
(use-package fish-completion)
(use-package eshell-did-you-mean)

;; Configure directory extension.

(use-package
  anzu
  :config (global-anzu-mode +1)
  :bind
  (("M-%" . anzu-query-replace) ("C-M-%" . anzu-query-replace-regexp)))

(setq org-agenda-files '("~/Documents/roam/todo.org"))

(use-package
  paredit
  :hook
  ((emacs-lisp-mode . paredit-mode)
   ;; (eval-expression-minibuffer-setup . paredit-mode)
   (scheme-mode . paredit-mode) (lisp-mode . paredit-mode)))

(setq inferior-lisp-program "sbcl")

(use-package
  multiple-cursors
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)))

;;;; * Eglot

(use-package
  eglot
  :bind ("C-c c" . compile) ("C-c l =" . eglot-format-buffer))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package git-gutter :config (global-git-gutter-mode +1))

					;(use-package savehist :init (savehist-mode))
(use-package company :config (global-company-mode 1))

;;;; * Elfeed

(use-package
  elfeed
  :config
  (setq elfeed-feeds
	'(("https://xkcd.com/rss.xml" comics)
          ("https://the-dam.org/rss.xml" unix dam)
          ("https://fsf.org/blogs/RSS" fsf)
          ("https://blog.tecosaur.com/tmio/rss.xml" emacs)
          ("https://guix.gnu.org/feeds/blog.atom" tech linux)
          ("https://vkc.sh/feed/" tech linux))))

(use-package avy :bind ("C-c q" . avy-goto-char-timer))

(use-package embark :bind ("C-." . embark-act))
(use-package embark-consult)

;;;; * Vertico

(use-package
  vertico
  :config (vertico-mode)
  :custom
  (vertico-count 20)
  (vertico-resize t)
  (enable-recursive-minibuffers t))

(use-package
  orderless
  :init
  (setq
   completion-styles '(orderless basic)
   completion-category-defaults nil
   completion-category-overrides '((file (styles partial-completion)))))

(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-r"))
(use-package
  consult
  :bind
  (("C-x b" . consult-buffer)
   ("C-t" . consult-goto-line)
   ("C-s" . consult-line)
   ("C-r l" . consult-register)
   ("C-r s" . consult-register-store)
   ("M-y" . consult-yank-from-kill-ring)))

(defhydra
 hydra-buffer
 (global-map "C-x")
 ("<right>" next-buffer)
 ("<left>" previous-buffer))


(global-unset-key (kbd "C-z"))

(use-package
  keychain-environment
  :config (keychain-refresh-environment))

(use-package adaptive-wrap)
(use-package all-the-icons)
(use-package all-the-icons-dired)
(use-package bind-map)
(use-package calfw)
(use-package cheat-sh)
(use-package circe)
(use-package consult-org-roam)
(use-package consult-yasnippet)
(use-package crux)
(use-package csv)
(use-package csv-mode)
(use-package dashboard)
(use-package debbugs)
(use-package dmenu)
(use-package ediprolog)
(use-package elpher)
(use-package ement)
(use-package engrave-faces)
(use-package flycheck)
(use-package flycheck-haskell)
(use-package gdscript-mode)
(use-package geiser-guile)
;;;; * Lisps

(use-package geiser :hook (scheme-mode geiser-mode))

;;;; * Misc

(use-package
  magit
  :bind
  (("C-c v s" . magit-stage)
   ("C-c v p" . magit-push)
   ("C-c v f" . magit-pull)
   ("C-c v c" . magit-commit)
   ("C-x g" . magit))
  :init
  (if (not (boundp 'project-switch-commands))
      (setq project-switch-commands nil)))

(use-package avy :bind ("C-c q" . avy-goto-char-timer))
(use-package
  browse-kill-ring
  :config (browse-kill-ring-default-keybindings))

(use-package embark :bind ("C-." . embark-act))
(use-package embark-consult)


(use-package gemini-mode)
(use-package go-mode)
					;(use-package hackles)
(use-package haskell-mode :hook (haskell-mode . eglot-ensure))
(use-package htmlize)
(use-package iedit)
(use-package markdown-mode)
(use-package multi-term)
(use-package nix-mode)
(use-package on-screen)
(use-package org-roam-ui)
(use-package org-superstar)
(use-package ox-gemini)
(use-package password-generator)
(use-package password-store)
(use-package password-store-otp)
(use-package pdf-tools)
(use-package realgud)
(use-package rust-mode)
(use-package sly)
(use-package swiper)
(use-package tldr)
(use-package yaml-mode)
(use-package yasnippet-snippets)
(use-package scala-mode :interpreter ("scala" . scala-mode))
(use-package elm-mode)
(use-package unison-ts-mode)
