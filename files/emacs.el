(use-package
 bind-key
 :config
 (add-to-list 'same-window-buffer-names "*Personal Keybindings*"))

(use-package hydra)

;;;; * Org-mode

(use-package org-modern :hook (org-mode . org-modern-mode))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t) (scheme . t) (dot . t) (lisp . t) (octave . t)))

(setq org-latex-default-packages-alist
      (cl-substitute-if
       '("colorlinks=true" "hyperref" nil)
       (lambda (entry) (string-equal (cl-second entry) "hyperref"))
       org-latex-default-packages-alist))

;;;; * Variable Init

(setq
 user-full-name "Michal Atlas"
 user-mail-address "michal_atlas+emacs@posteo.net")
;; (setq user-full-name "Michal Žáček"
;;       user-mail-address "zacekmi2@fit.cvut.cz"

(setq-default indent-tabs-mode nil)

(setq backup-directory-alist '((".*" . "~/.emacs.d/bkp")))
(setq enable-local-variables :all)
(setq calendar-week-start-day 1)
(setq find-function-C-source-directory "~/cl/emacs")
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq visible-bell t)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(run-at-time nil (* 10 60) 'recentf-save-list)
(defun yes-or-no-p (prompt)
  (y-or-n-p prompt))
(setq auth-sources '("~/.authinfo.gpg"))

;;;; * Scrolling

(setq
 scroll-step 1
 scroll-conservatively 10000
 auto-window-vscroll nil
 scroll-margin 8)

(pixel-scroll-precision-mode t)

;;; Scrolling.
;; Good speed and allow scrolling through large images (pixel-scroll).
;; Note: Scroll lags when point must be moved but increasing the number
;;       of lines that point moves in pixel-scroll.el ruins large image
;;       scrolling. So unfortunately I think we'll just have to live with
;;       this.
;; (pixel-scroll-mode 0)
;; (setq pixel-dead-time 0 ; Never go back to the old scrolling behaviour.
;;       pixel-resolution-fine-flag t ; Scroll by number of pixels instead of lines (t = frame-char-height pixels).
;;       mouse-wheel-scroll-amount '(1) ; Distance in pixel-resolution to scroll each mouse wheel event.
;;       mouse-wheel-progressive-speed nil) ; Progressive speed is too fast for me.

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

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; (use-package mode-icons :config (mode-icons-mode 1))
;; (elpaca-wait)
(use-package direnv :config (direnv-mode t))

;;;; * Theme

;;;; ** Monokai

(use-package monokai-theme :config (load-theme 'monokai t))

;;;; * Modeline

(use-package doom-modeline :config (doom-modeline-mode 1))

;;;; * Completion

(global-set-key [remap dabbrev-expand] 'hippie-expand)

;;;; * Packages 


(use-package which-key :config (which-key-mode))
(setq which-key-popup-type 'minibuffer)

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
       '(("." . "~/.emacs.d/undo"))))

;;;; * Eglot

(use-package
 eglot
 :bind ("C-c c" . compile) ("C-c l =" . eglot-format-buffer))

(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(use-package git-gutter :config (global-git-gutter-mode +1))

;; Persist history over Emacs restarts. Vertico sorts by history position.

;(use-package savehist :init (savehist-mode))

;; Configure directory extension.

(use-package
 anzu
 :config (global-anzu-mode +1)
 :bind
 (("M-%" . anzu-query-replace) ("C-M-%" . anzu-query-replace-regexp)))

(use-package marginalia :config (marginalia-mode))

(setq org-agenda-files '("~/Documents/roam/todo.org"))

;;;; * Langs

(use-package company :config (global-company-mode 1))

;;;; * Lisps

(use-package geiser :hook (scheme-mode geiser-mode))

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

;;;; * C

(add-hook 'shell-script-mode 'prog-mode)

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

(use-package
 browse-kill-ring
 :config (browse-kill-ring-default-keybindings))

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

(global-unset-key (kbd "C-r"))

(defhydra
 hydra-buffer
 (global-map "C-x")
 ("<right>" next-buffer)
 ("<left>" previous-buffer))


(global-unset-key (kbd "C-z"))

(use-package adaptive-wrap)
(use-package crux)
(use-package htmlize)
(use-package pdf-tools)
(use-package sly)
(use-package swiper)
