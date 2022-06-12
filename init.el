;; Packaging Bootstrap

;; [[file:../dotmas/init.org::*Packaging Bootstrap][Packaging Bootstrap:1]]
(setq straight-use-package-by-default t)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(straight-use-package 'use-package)
;; Packaging Bootstrap:1 ends here

;; Variable Init

;; [[file:../dotmas/init.org::*Variable Init][Variable Init:1]]
;; (setq user-full-name "Michal Atlas"
;;       user-mail-address "michal.z.atlas@gmail.com")
(setq user-full-name "Michal Žáček"
      user-mail-address "zacekmi2@fit.cvut.cz")

(setq backup-directory-alist '((".*" . "~/.emacs.d/bkp")))
(setq projectile-project-search-path (list "~/Documents" "~/source"))
(setq calendar-week-start-day 1)
(setq org-agenda-start-on-weekday 1)
(setq find-function-C-source-directory "~/source/emacs")
(global-auto-revert-mode 1)
(recentf-mode 1)
(setq visible-bell t)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 10 60) 'recentf-save-list)
;; Variable Init:1 ends here

(defun yes-or-no-p (prompt) (y-or-n-p prompt))
(windmove-default-keybindings)
;; Variable Init:1 ends here

;; Theming 

;; [[file:../dotmas/init.org::*Theming][Theming:1]]
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(use-package highlight-indentation
  :hook (prog-mode . highlight-indentation-mode)
  :custom (highlight-indent-guides-method 'bitmap))
(use-package solaire-mode
  :config (solaire-global-mode +1))
					; (set-frame-font "Fira Code-11" nil t)
					; (add-to-list 'default-frame-alist '(font . "Fira Code-11"))
(use-package all-the-icons)
;; (use-package mode-icons :config (mode-icons-mode 1))
;; Theming:1 ends here

;; Theme

;; [[file:../dotmas/init.org::*Theme][Theme:1]]
(use-package gruvbox-theme
  :straight (:host github :repo "greduan/emacs-theme-gruvbox")
  :config (load-theme 'gruvbox-dark-hard t))
;; Theme:1 ends here

;; Modeline

;; [[file:../dotmas/init.org::*Modeline][Modeline:1]]
(use-package doom-modeline :init (doom-modeline-mode 1))
;; Modeline:1 ends here

;; Completion

;; [[file:../dotmas/init.org::*Completion][Completion:1]]
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(use-package yasnippet-snippets)
(use-package yasnippet
  :config (yas-global-mode 1))
;; Completion:1 ends here

;; Packages 

;; [[file:../dotmas/init.org::*Packages][Packages:1]]
(use-package which-key
  :config (which-key-mode))
(setq which-key-popup-type 'minibuffer)

(use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-default 'preview-scale-function 1.5)

(use-package undo-tree
  :config (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package system-packages)

;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling 
;; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; (setq scroll-conservatively 10000)
;; (setq auto-window-vscroll nil)
;; (setq scroll-conservatively 10000)

;; (guix-prettify-global-mode +1)

(use-package aggressive-indent)
;; Packages:1 ends here

;; Eshell

;; [[file:../dotmas/init.org::*Eshell][Eshell:1]]
(use-package eshell-prompt-extras
  :config
  (with-eval-after-load "esh-opt"
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
	  eshell-prompt-function 'epe-theme-lambda)))

(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))

(use-package eshell-z)
(add-hook 'eshell-mode-hook
	  (defun my-eshell-mode-hook ()
	    (require 'eshell-z)))

(require 'eshell)
(use-package eshell-syntax-highlighting
  :config (eshell-syntax-highlighting-global-mode 1))
(setq eshell-review-quick-commands nil)
(require 'esh-module) ; require modules
(add-to-list 'eshell-modules-list 'eshell-tramp)
(use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))
;; Eshell:1 ends here

;; LSP

;; [[file:../dotmas/init.org::*LSP][LSP:1]]
(use-package lsp-mode
  :bind ("C-c c" . compile)
  :custom (lsp-keymap-prefix "C-c l")
  :hook (lsp-mode . lsp-enable-which-key-integration))

(global-set-key (kbd "C-c o c") 'cfw:open-calendar-buffer)

(use-package git-gutter
  :config (global-git-gutter-mode +1))
;; LSP:1 ends here

;; Vertico

;; [[file:../dotmas/init.org::*Vertico][Vertico:1]]
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  (setq vertico-scroll-margin 0)

  ;; Show more candidates
  (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
		  (replace-regexp-in-string
		   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
		   crm-separator)
		  (car args))
	  (cdr args)))
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

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

;; Configure directory extension.

(use-package anzu
  :config (global-anzu-mode +1)
  :bind (("M-%" . anzu-query-replace)
	 ("C-M-%" . anzu-query-replace-regexp)))
;; Vertico:1 ends here

;; Org-mode

;; [[file:../dotmas/init.org::*Org-mode][Org-mode:1]]
(use-package org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (dot . t)
   (C . t)
   (shell . t)
   (scheme . t)
   ))
(use-package org-present)
;; (use-package org-fragtog
;; :hook (org-mode org-fragtog-mode))
(use-package org-modern
  :config (global-org-modern-mode))
(use-package marginalia
  :config (marginalia-mode))

(setq org-agenda-files '("~/roam/todo.org"))
;; Org-mode:1 ends here

;; Roam

;; [[file:../dotmas/init.org::*Roam][Roam:1]]
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/roam/"))
  (org-roam-capture-templates
   '(
     ("d" "default" plain "%?" :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
  ")
      :unnarrowed t)
     ("p" "people" plain "%?" :target
      (file+head "people/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
  ")
      :unnarrowed t)
     ("f" "food" plain "%?" :target
      (file+head "food/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
  ")
      :unnarrowed nil)
     ))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n g" . org-roam-graph)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ;; Dailies
	 ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))
(use-package org-roam-ui
  :straight
  (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
  :after org-roam
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;; :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
	org-roam-ui-follow t
	org-roam-ui-update-on-save t
	org-roam-ui-open-on-start t))
(use-package org-drill)
;; Roam:1 ends here

;; Calfw

;; [[file:../dotmas/init.org::*Calfw][Calfw:1]]
(use-package calfw)
(use-package calfw-org
  :bind ("C-c d" . cfw:open-org-calendar))
;; Calfw:1 ends here

;; Langs

;; [[file:../dotmas/init.org::*Langs][Langs:1]]
;; Lisps

(use-package auto-complete
  :config (ac-config-default))
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(add-to-list 'ac-modes' geiser-repl-mode)

(use-package slime
  :hook (common-lisp-mode slime-mode))
(use-package geiser
  :hook (scheme-mode geiser-mode))

(use-package paredit
  :config (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  :hook ((emacs-lisp-mode . enable-paredit-mode)
	 (eval-expression-minibuffer-setup . enable-paredit-mode)
	 (lisp-mode . enable-paredit-mode)
	 (lisp-mode . aggressive-indent-mode)))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; C

(use-package irony)
(use-package irony-eldoc)
(add-hook 'c-mode-hook #'irony-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'irony-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'irony-mode-hook #'irony-cdb-autosetup-compile-options)

(add-hook 'irony-mode-hook #'irony-eldoc)

(add-hook 'shell-script-mode 'prog-mode)
;; Langs:1 ends here

;; Elfeed

;; [[file:../dotmas/init.org::*Elfeed][Elfeed:1]]
(use-package elfeed)
(setq elfeed-feeds
      '(("https://xkcd.com/rss.xml" comics)
	("https://www.smbc-comics.com/comic/rss" comics)
	("https://www.giantitp.com/comics/oots.rss" comics)
	("https://feeds.feedburner.com/LookingForGroup" comics)
	("https://www.oglaf.com/" comics)
	("http://phdcomics.com/gradfeed.php" comics)
	("https://blog.tecosaur.com/tmio/rss.xml" emacs)
	("http://festivalofthespokennerd.libsyn.com/rss" podcast)
	("https://guix.gnu.org/feeds/blog.atom")))

(provide 'init)
;; Elfeed:1 ends here

;; Misc

;; [[file:../dotmas/init.org::*Misc][Misc:1]]
(use-package equake
  :straight (equake :fetcher gitlab :repo "emacsomancer/equake")
  ;; some examples of optional settings follow:
  :custom
  ;; set width a bit less than full-screen (prevent 'overflow' on multi-monitor):
  (equake-size-width 0.99)
  ;; set distinct face for Equake: white foreground with dark blue background, and different font:
  :config
  ;; prevent accidental frame closure:
  (advice-add #'save-buffers-kill-terminal :before-while #'equake-kill-emacs-advice)
  ;; binding to restore last Equake tab when viewing a non-Equake buffer
  (global-set-key (kbd "C-M-^") #'equake-restore-last-etab)
  ;; set default shell
  (setq equake-default-shell 'eshell)
  ;; set list of available shells
  (setq equake-available-shells
	'("shell"
	  "vterm"
	  "rash"
	  "eshell")))
(use-package magit
  :bind (("C-c v s" . magit-stage)
	 ("C-c v p" . magit-push)
	 ("C-c v f" . magit-pull)
	 ("C-c v c" . magit-commit)
	 ("C-x g" . magit))
  :init (if (not (boundp 'project-switch-commands)) 
	    (setq project-switch-commands nil)))
(use-package flycheck)
(use-package helpful
  :bind (("C-h f" . helpful-function)
	 ("C-h k" . helpful-key)))

(use-package crux)
(use-package lsp-ui)
(use-package magit-todos)
(use-package adaptive-wrap)
(use-package pdf-tools)
(use-package avy
  :bind ("C-c q" . avy-goto-char-timer))
(use-package embark)
(use-package consult)
(use-package elpher)
(use-package multiple-cursors)
(use-package on-screen)
(use-package notmuch)
(use-package tldr)
(use-package direnv)
(use-package kana
  :straight
  (:repo "chenyanming/kana" :fetcher github))
(use-package circe)
(use-package browse-kill-ring
  :config (browse-kill-ring-default-keybindings))
(use-package realgud)
(use-package gdscript-mode)
(use-package gemini-mode :straight (:repo "http://git.carcosa.net/jmcbray/gemini.el.git" :files ("*.el")))

(use-package xkcd :straight (xkcd :fetcher github :repo "vibhavp/emacs-xkcd"))
(use-package hackles
  :straight (:host github :repo "Michal-Atlas/emacs-hackles"))
;; Misc:1 ends here

;; Embark

;; [[file:../dotmas/init.org::*Embark][Embark:1]]
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
;; Embark:1 ends here

;; EMMS

;; [[file:../dotmas/init.org::*EMMS][EMMS:1]]
(use-package emms
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "~/Music/")
  (setq-default
   emms-source-file-default-directory "~/Music/"

   emms-source-playlist-default-format 'native
   emms-playlist-mode-center-when-go t
   emms-playlist-default-major-mode 'emms-playlist-mode
   emms-show-format "NP: %s"

   emms-player-list '(emms-player-mpv)
   emms-player-mpv-environment '("PULSE_PROP_media.role=music")
   emms-player-mpv-parameters '("--quiet" "--really-quiet" "--no-video" "--no-audio-display" "--force-window=no" "--vo=null")))
;; EMMS:1 ends here

;; Thaumiel 

;; [[file:../dotmas/init.org::*Thaumiel][Thaumiel:1]]
;      (straight-use-package '(thaumiel :local-repo "thaumiel" :repo "michal_atlas/thaumiel"))
;; Thaumiel:1 ends here

;; Matrix

;; [[file:../dotmas/init.org::*Matrix][Matrix:1]]
(straight-use-package '(plz :host github :repo "alphapapa/plz.el"))
(straight-use-package '(ement :host github :repo "alphapapa/ement.el"))
;; Matrix:1 ends here

;; Evil

;; [[file:../dotmas/init.org::*Evil][Evil:1]]
;; (use-package evil
;;   :config (evil-mode 1))
;; Evil:1 ends here
