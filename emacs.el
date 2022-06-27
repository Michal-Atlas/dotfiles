;; Variable Init

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

(defun yes-or-no-p (prompt) (y-or-n-p prompt))

;; WindMove

(windmove-default-keybindings)
(global-set-key (kbd "s-<up>") #'windmove-swap-states-up)
(global-set-key (kbd "s-<down>") #'windmove-swap-states-down)
(global-set-key (kbd "s-<left>") #'windmove-swap-states-left)
(global-set-key (kbd "s-<right>") #'windmove-swap-states-right)

;; Theming 

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)
(display-battery-mode 1)
(display-time-mode 1)
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

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; (use-package mode-icons :config (mode-icons-mode 1))

;; Theme

(setq modus-themes-subtle-line-numbers t
      modus-themes-mode-line '(accented)
      modus-themes-syntax '(yellow-comments)
      modus-themes-paren-match '(bold intense)
      modus-themes-prompts '(intense)
      modus-themes-region '(no-extend bg-only accented)
      modus-themes-bold-constructs t
      modus-themes-hl-line '(accented intense))
(load-theme 'modus-vivendi t)

;; Modeline

(use-package doom-modeline :init (doom-modeline-mode 1))

;; Completion

(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Tramp

(setq tramp-default-method "ssh")

;; Packages 

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

(guix-prettify-global-mode +1)


;; Eshell

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

;; LSP

(use-package lsp-mode
  :bind ("C-c c" . compile)
  :custom (lsp-keymap-prefix "C-c l")
  :hook (lsp-mode . lsp-enable-which-key-integration))

(global-set-key (kbd "C-c o c") 'cfw:open-calendar-buffer)

(use-package git-gutter
  :config (global-git-gutter-mode +1))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Configure directory extension.

(use-package anzu
  :config (global-anzu-mode +1)
  :bind (("M-%" . anzu-query-replace)
	 ("C-M-%" . anzu-query-replace-regexp)))

;; Org-mode

;; (use-package org-fragtog
;; :hook (org-mode org-fragtog-mode))
(use-package org-modern
  :hook (org-mode . org-modern-mode))
(use-package marginalia
  :config (marginalia-mode))

(setq org-agenda-files '("~/roam/todo.org"))

;; Roam

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
;; (use-package org-roam-ui
;;   :after org-roam
;;   ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;   ;;         a hookable mode anymore, you're advised to pick something yourself
;;   ;;         if you don't care about startup time, use
;;   ;; :hook (after-init . org-roam-ui-mode)
;;   :config
;;   (setq org-roam-ui-sync-theme t
;; 	org-roam-ui-follow t
;; 	org-roam-ui-update-on-save t
;; 	org-roam-ui-open-on-start t))


;; Langs

;; Lisps

(use-package auto-complete
  :config (ac-config-default))
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(add-to-list 'ac-modes' geiser-repl-mode)

(use-package slime
  :hook (common-lisp-mode slime-mode))
;; (use-package geiser
;;   :hook (scheme-mode geiser-mode))

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

(add-hook 'c-mode-hook #'irony-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'irony-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'irony-mode-hook #'irony-cdb-autosetup-compile-options)

(add-hook 'irony-mode-hook #'irony-eldoc)

(add-hook 'shell-script-mode 'prog-mode)

;; Elfeed

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

;; Misc

(use-package magit
  :bind (("C-c v s" . magit-stage)
	 ("C-c v p" . magit-push)
	 ("C-c v f" . magit-pull)
	 ("C-c v c" . magit-commit)
	 ("C-x g" . magit))
  :init (if (not (boundp 'project-switch-commands)) 
	    (setq project-switch-commands nil)))
					; (use-package helpful
					;   :bind (("C-h f" . helpful-function)
					;	 ("C-h k" . helpful-key)))

(use-package avy
  :bind ("C-c q" . avy-goto-char-timer))
(use-package browse-kill-ring
  :config (browse-kill-ring-default-keybindings))


;; EMMS

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

;; Thaumiel 

;      (straight-use-package '(thaumiel :local-repo "thaumiel" :repo "michal_atlas/thaumiel"))

;; Matrix


;; Evil

;; (use-package evil
;;   :config (evil-mode 1))

(connection-local-set-profile-variables
 'guix-system
 '((tramp-remote-path . (tramp-own-remote-path))))

(connection-local-set-profiles
 `(:application tramp :protocol "sudo" :machine ,(system-name))
 'guix-system)

(defun guix/recon/home ()
  (interactive)
  (async-shell-command
   (concat "guix time-machine -C "
	   (expand-file-name "~/dotfiles/channels.lock") " -- home reconfigure -L "
	   (expand-file-name "~/dotfiles") " "
	   (expand-file-name "~/dotfiles/atlas/home/home.scm"))
   ))

(defun guix/recon/system ()
  (interactive)
  (async-shell-command
   (concat "sudo guix time-machine -C " (getenv "HOME")
	   "/dotfiles/channels.lock -- system reconfigure -L " (expand-file-name "~/dotfiles") " "
	   (expand-file-name "~/dotfiles/atlas/system/system.scm"))))

(defun guix/update-locks ()
  (interactive)
  (async-shell-command
   (concat "guix pull && guix describe --format=channels > "
	   (expand-file-name "~/dotfiles/channels.lock"))))

(defun guix/patch (path)
  (interactive "f")
  (shell-command (concat "patchelf " path " --set-rpath "
			 "\"/run/current-system/profile/lib:/home/"
			 (getenv "USER")
			 "/.guix-home/profile/lib"
			 (apply #'concat
				(mapcar (lambda (x) (concat ":" x "/lib"))
					(split-string
			 		 (shell-command-to-string "guix package --list-profiles"))))
			 "\""))
  (shell-command (concat
		  "patchelf " path
		  " --set-interpreter \"/run/current-system/profile/lib/ld-linux-x86-64.so.2\""))
  (message (format "RPATH: %sLD: %s"
		   (shell-command-to-string (concat "patchelf " path " --print-rpath"))
		   (shell-command-to-string (concat "patchelf " path " --print-interpreter")))))

(defun light/up ()
  (interactive)
  (shell-command "light -A 10")
  (light/show))

(defun light/down ()
  (interactive)
  (shell-command "light -U 10")
  (light/show))

(defun light/show ()
  (princ
   (concat
    "Brightness..." (string-trim (shell-command-to-string "light -G")) "%")))

(defun volume/up ()
  (interactive)
  (shell-command "pactl set-sink-volume @DEFAULT_SINK@ +5%")
  (volume/show))

(defun volume/down ()
  (interactive)
  (shell-command "pactl set-sink-volume @DEFAULT_SINK@ -5%")
  (volume/show))

(defun volume/mute ()
  (interactive)
  (shell-command "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  (volume/show))

(defun volume/show ()
  (princ
   (string-trim (shell-command-to-string "pactl get-sink-volume @DEFAULT_SINK@"))))

(defun player/play ()
  (shell-command "playerctl play-pause"))
(defun player/next ()
  (shell-command "playerctl next"))
(defun player/prev ()
  (shell-command "playerctl previous"))

(global-set-key (kbd "<XF86AudioPlay>") #'player/play)
(global-set-key (kbd "<XF86AudioNext>") #'player/next)
(global-set-key (kbd "<XF86AudioPrev>") #'player/prev)
(global-set-key (kbd "<XF86AudioRaiseVolume>") #'volume/up)
(global-set-key (kbd "<XF86AudioLowerVolume>") #'volume/down)
(global-set-key (kbd "<XF86AudioMute>") #'volume/mute)
(global-set-key (kbd "<XF86MonBrightnessUp>") #'light/up)
(global-set-key (kbd "<XF86MonBrightnessDown>") #'light/down)

;; EXWM

(use-package exwm
  :custom
  (exwm-workspace-number 5)
  :config
  (add-hook 'exwm-update-class-hook
	    (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (start-process-shell-command "nm-applet" nil "nm-applet")
  (setq
   exwm-input-prefix-keys
   `(?\C-x
     ?\C-u
     ?\C-h
     ?\M-x
     ?\M-`
     ?\M-&
     ?\M-:
     ?\C-\ 
     ,(kbd "<XF86AudioPlay>")
     ,(kbd "<XF86AudioNext>")
     ,(kbd "<XF86AudioPrev>")
     ,(kbd "<XF86AudioRaiseVolume>")
     ,(kbd "<XF86AudioLowerVolume>")
     ,(kbd "<XF86AudioMute>")
     ,(kbd "<XF86MonBrightnessUp>")
     ,(kbd "<XF86MonBrightnessDown>"))
   
   exwm-input-global-keys
   `(([?\s-&] . (lambda (command) (interactive (list (read-shell-command "$ ")))
		  (start-process-shell-command command nil command)))
     ([?\s-w] . exwm-workspace-switch)
     ,@(mapcar (lambda (i)
		 `(,(kbd (format "s-%d" i)) .
		   (lambda ()
		     (interactive)
		     (exwm-workspace-switch-create ,i))))
	       (number-sequence 0 9))))
  (require 'exwm-config)
  (exwm-config-default)
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key))

;; Vertico

(use-package vertico
  :init
  (vertico-mode)
  (ido-mode 0)
  :custom
  (vertico-count 20)
  (vertico-resize t)
  (enable-recursive-minibuffers t))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind (("C-x b" . consult-buffer)
	 ("M-y" . consult-yank-from-kill-ring)))
