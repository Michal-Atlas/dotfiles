(declare-function elpaca-generate-autoloads "elpaca")
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(when-let ((elpaca-repo (expand-file-name "repos/elpaca/" elpaca-directory))
           (elpaca-build (expand-file-name "elpaca/" elpaca-builds-directory))
           (elpaca-target (if (file-exists-p elpaca-build) elpaca-build elpaca-repo))
           (elpaca-url  "https://www.github.com/progfolio/elpaca.git")
           ((add-to-list 'load-path elpaca-target))
           ((not (file-exists-p elpaca-repo)))
           (buffer (get-buffer-create "*elpaca-bootstrap*")))
  (condition-case-unless-debug err
      (progn
        (unless (zerop (call-process "git" nil buffer t "clone" elpaca-url elpaca-repo))
          (error "%s" (list (with-current-buffer buffer (buffer-string)))))
        (byte-recompile-directory elpaca-repo 0 'force)
        (require 'elpaca)
        (elpaca-generate-autoloads "elpaca" elpaca-repo)
        (kill-buffer buffer))
    ((error)
     (delete-directory elpaca-directory 'recursive)
     (with-current-buffer buffer
       (goto-char (point-max))
       (insert (format "\n%S" err))
       (display-buffer buffer)))))
(require 'elpaca-autoloads)
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca (elpaca :host github :repo "progfolio/elpaca"))

(elpaca use-package)
(elpaca-use-package hydra)

;; Variable Init

(setq user-full-name "Michal Atlas"
      user-mail-address "michal_atlas+emacs@posteo.net")
;; (setq user-full-name "Michal Žáček"
;;       user-mail-address "zacekmi2@fit.cvut.cz"

(setq backup-directory-alist '((".*" . "~/.emacs.d/bkp")))
(setq projectile-project-search-path (list "~/Documents" "~/source" "~/cl"))
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
(global-prettify-symbols-mode +1)

(defun yes-or-no-p (prompt) (y-or-n-p prompt))
;(dired-async-mode 1)
(setq auth-sources '("~/.authinfo.gpg"))

;; Scrolling

(setq scroll-step 1
      scroll-conservatively 10000
      auto-window-vscroll nil
      scroll-margin 8)

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
(setq display-time-24hr-format t)
(display-time-mode 1)
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode)
(global-hl-line-mode 1)


(elpaca-use-package highlight-indentation
  :hook (prog-mode . highlight-indentation-mode)
  :custom (highlight-indent-guides-method 'bitmap))
(elpaca-use-package solaire-mode
  :config (solaire-global-mode +1))
					; (set-frame-font "Fira Code-11" nil t)
					; (add-to-list 'default-frame-alist '(font . "Fira Code-11"))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; (elpaca-use-package mode-icons :config (mode-icons-mode 1))

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

(elpaca-use-package doom-modeline :init (doom-modeline-mode 1))

;; Completion

(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Tramp

(setq tramp-default-method "ssh")

;; Packages 

(elpaca-use-package which-key
  :config (which-key-mode))
(setq which-key-popup-type 'minibuffer)

(elpaca-use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))
(elpaca-use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(set-default 'preview-scale-function 1.5)

(elpaca-use-package undo-tree
  :config (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

(elpaca-use-package ace-window
  :bind ("M-o" . ace-window))

;(guix-prettify-global-mode +1)


;; Eshell

(elpaca-use-package eshell-prompt-extras
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
(elpaca-use-package eshell-syntax-highlighting
  :config (eshell-syntax-highlighting-global-mode 1))
(setq eshell-review-quick-commands nil)
(require 'esh-module) ; require modules
(add-to-list 'eshell-modules-list 'eshell-tramp)
(elpaca-use-package esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

;; LSP

(elpaca-use-package lsp-mode
  :bind ("C-c c" . compile)
  :custom (lsp-keymap-prefix "C-c l")
  :hook (lsp-mode . lsp-enable-which-key-integration))

(global-set-key (kbd "C-c o c") 'cfw:open-calendar-buffer)

(elpaca-use-package git-gutter
  :config (global-git-gutter-mode +1))

;; Persist history over Emacs restarts. Vertico sorts by history position.

;(elpaca-use-package savehist :init (savehist-mode))

;; Configure directory extension.

(elpaca-use-package anzu
  :config (global-anzu-mode +1)
  :bind (("M-%" . anzu-query-replace)
	 ("C-M-%" . anzu-query-replace-regexp)))

;; Org-mode

;; (elpaca-use-package org-fragtog
;; :hook (org-mode org-fragtog-mode))
(elpaca-use-package org-modern
  :hook (org-mode . org-modern-mode))
(elpaca-use-package marginalia
  :config (marginalia-mode))

(setq org-agenda-files '("~/roam/todo.org"))

;; Roam

(elpaca-use-package org-roam
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
;; (elpaca-use-package org-roam-ui
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

(elpaca-use-package auto-complete
  :config (ac-config-default))
(elpaca-use-package geiser-racket)
(elpaca-use-package adaptive-wrap)
(elpaca-use-package geiser-guile
  :config
  (add-hook 'geiser-mode-hook 'ac-geiser-setup)
  (add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
  (add-to-list 'ac-modes' geiser-repl-mode))

(elpaca-use-package slime
  :hook (common-lisp-mode slime-mode))
;; (elpaca-use-package geiser
;;   :hook (scheme-mode geiser-mode))

(elpaca-use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
	 (eval-expression-minibuffer-setup . paredit-mode)
	 (scheme-mode . paredit-mode)))

(elpaca-use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)))

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
	("https://guix.gnu.org/feeds/blog.atom" tech linux)
	("https://vkc.sh/feed/" tech linux)
	("https://www.youtube.com/feeds/videos.xml?channel_id=UCMiyV_Ib77XLpzHPQH_q0qQ") ;; Veronica
	("https://www.youtube.com/feeds/videos.xml?channel_id=UCQ6fPy9wr7qnMxAbFOGBaLw") ;; Computer Clan
	("https://lexfridman.com/feed/podcast/")
	))

;; Misc

(elpaca-use-package magit
  :bind (("C-c v s" . magit-stage)
	 ("C-c v p" . magit-push)
	 ("C-c v f" . magit-pull)
	 ("C-c v c" . magit-commit)
	 ("C-x g" . magit))
  :init (if (not (boundp 'project-switch-commands)) 
	    (setq project-switch-commands nil)))
					; (elpaca-use-package helpful
					;   :bind (("C-h f" . helpful-function)
					;	 ("C-h k" . helpful-key)))

(elpaca-use-package avy
  :bind ("C-c q" . avy-goto-char-timer))
(elpaca-use-package browse-kill-ring
  :config (browse-kill-ring-default-keybindings))


;; EMMS

(elpaca-use-package emms
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

;      (straight-elpaca-use-package '(thaumiel :local-repo "thaumiel" :repo "michal_atlas/thaumiel"))

;; Matrix


;; Evil

;; (elpaca-use-package evil
;;   :config (evil-mode 1))

(connection-local-set-profile-variables
 'guix-system
 '((tramp-remote-path . (tramp-own-remote-path))))

(connection-local-set-profiles
 `(:application tramp :protocol "sudo" :machine ,(system-name))
 'guix-system)

(defun guix/offload-y-or-n-p ()
  (if (y-or-n-p "Enable offloads?") "" " --no-offload "))

(defun guix/recon/home ()
  (interactive)
  (let ((offl (guix/offload-y-or-n-p)))
    (async-shell-command
     (concat "guix time-machine"
	     offl
	     " -C " (expand-file-name "~/dotfiles/channels.lock")
	     " -- home reconfigure"
	     offl" -L "
	     (expand-file-name "~/dotfiles") " "
	     (expand-file-name "~/dotfiles/atlas/home/home.scm"))
     "guix/recon/home:out" "guix/recon/home:err")))

(defun guix/recon/system ()
  (interactive)
  (let ((offl (guix/offload-y-or-n-p)))
    (async-shell-command
     (concat "sudo guix time-machine" offl " -C " (getenv "HOME")
	     "/dotfiles/channels.lock -- system reconfigure"
	     offl " -L " (expand-file-name "~/dotfiles") " "
	     (expand-file-name (concat "~/dotfiles/atlas/system/machines/" system-name ".scm")))
     "guix/recon/system:out" "guix/recon/system:err")))

(defun guix/update-locks ()
  (interactive)
  (let ((offl (guix/offload-y-or-n-p)))
    (async-shell-command
     (concat "guix pull " offl " && guix describe --format=channels > "
	     (expand-file-name "~/dotfiles/channels.lock"))
     "guix/update-locks:out" "guix/update-locks:err")))

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
  (interactive)
  (shell-command "playerctl play-pause"))
(defun player/next ()
  (interactive)
  (shell-command "playerctl next"))
(defun player/prev ()
  (interactive)
  (shell-command "playerctl previous"))

(global-set-key (kbd "s-<return>") (lambda () (interactive)
				     (start-process-shell-command "kitty" nil "kitty")))

(defhydra hydra-system (global-map "C-c s")
  "system"
  ("p" player/play "Play")
  ("o" player/next "Next")
  ("i" player/prev "Prev")
  ("e" light/up "Br. Up")
  ("d" light/down "Br. Down")
  ("r" volume/up "Vol. Up")
  ("f" volume/down "Vol. Down")
  ("m" volume/mute "Mute"))

(defhydra hydra-launcher (global-map "C-c r" :color purple :exit t)
  "Launch"
  ("r" (browse-url "http://www.reddit.com/r/emacs/") "reddit")
  ("w" (browse-url "http://www.emacswiki.org/") "emacswiki")
  ("f" (start-process-shell-command "firefox" nil "firefox") "firefox")
  ("d" (start-process-shell-command "discord" nil "flatpak run com.discordapp.Discord") "discord")
  ("s" shell "shell")
  ("e" eshell "eshell")
  ("l" (start-process-shell-command "lagrange" nil "lagrange") "lagrange")
  ("g" guix-packages-by-name "find package")
  ("q" nil "cancel"))

(defhydra hydra-buffer (global-map "C-x")
  ("<right>" next-buffer)
  ("<left>" previous-buffer))

(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "C-c p") #'paredit-mode)

;; EXWM

;; (elpaca-use-package exwm
;;   :custom
;;   (exwm-workspace-number 5)
;;   :bind
;;   ("C-M-l" . (lambda () (interactive) (shell-command "slimlock")))
;;   :config
;;   (add-hook 'exwm-update-class-hook
;; 	    (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;;   (require 'exwm-systemtray)
;;   (exwm-systemtray-enable)
;;   (set-frame-parameter (selected-frame) 'alpha '(85 . 85))
;;   (add-to-list 'default-frame-alist '(alpha . (85 . 85)))
;;   (dolist (cmd '("nm-applet" "pasystray"
;; 		 "picom" ("feh" . "feh -z --recursive --bg-fill ~/documents/Wallpapers/Gnu_wallpaper.png")
;; 		 ("xsslock" . "xsslock -- slimlock")))
;;     (if (listp cmd)
;; 	(start-process-shell-command (car cmd) nil (cdr cmd))
;;       	(start-process-shell-command (file-name-nondirectory cmd) nil cmd)))
;;   (setq
;;    exwm-workspace-show-all-buffers t
;;    ;; exwm-workspace-minibuffer-position 'top

;;    exwm-input-prefix-keys
;;    `(?\C-x
;;      ?\C-u
;;      ?\C-h
;;      ?\M-x
;;      ?\M-`
;;      ?\M-&
;;      ?\M-:)

;;    exwm-input-simulation-keys
;;    '(([?\C-b] . [left])
;;      ([?\C-f] . [right])
;;      ([?\C-p] . [up])
;;      ([?\C-n] . [down])
;;      ([?\C-a] . [home])
;;      ([?\C-e] . [end])
;;      ([?\M-v] . [prior])
;;      ([?\C-v] . [next])
;;      ([?\C-d] . [delete])
;;      ([?\C-k] . [S-end delete]))

;;    exwm-input-global-keys
;;    `(([?\s-&] . (lambda (command) (interactive (list (read-shell-command "$ ")))
;; 		  (start-process-shell-command command nil command)))
;;      ([?\s-w] . exwm-workspace-switch)
;;      (,(kbd "<XF86AudioPlay>") . player/play)
;;      (,(kbd "<XF86AudioNext>") . player/next)
;;      (,(kbd "<XF86AudioPrev>") . player/prev)
;;      (,(kbd "<XF86AudioRaiseVolume>") . volume/up)
;;      (,(kbd "<XF86AudioLowerVolume>") . volume/down)
;;      (,(kbd "<XF86AudioMute>") . volume/mute)
;;      (,(kbd "<XF86MonBrightnessUp>") . light/up)
;;      (,(kbd "<XF86MonBrightnessDown>") . light/down)
;;      ,@(mapcar (lambda (i)
;; 		 `(,(kbd (format "s-%d" i)) .
;; 		   (lambda ()
;; 		     (interactive)
;; 		     (exwm-workspace-switch-create ,i))))
;; 	       (number-sequence 0 9))
;;      ,@(mapcar (lambda (i)
;; 		 `(,(kbd (format "M-s-%d" i)) .
;; 		   (lambda ()
;; 		     (interactive)
;; 		     (eshell ,i))))
;; 	       (number-sequence 0 9))))
;;   (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)

;; (defun efs/configure-window-by-class () (interactive)
;; 	 (pcase exwm-class-name
;; 	   ("Firefox" (exwm-workspace-move-window 3))
;; 	   ("mpv" (exwm-workspace-move-window 7))))
;; (add-hook 'exwm-manage-finish-hook #'efs/configure-window-by-class)

;; (exwm-enable))

;; Vertico

(elpaca-use-package vertico
  :init
  (vertico-mode)
  :custom
  (vertico-count 20)
  (vertico-resize t)
  (enable-recursive-minibuffers t))

(elpaca-use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(global-unset-key (kbd "C-r"))
(elpaca-use-package consult
  :bind (("C-x b" . consult-buffer)
	 ("C-t" . consult-goto-line)
	 ("C-s" . consult-line)
	 ("C-r l" . consult-register)
	 ("C-r s" . consult-register-store)
	 ("M-y" . consult-yank-from-kill-ring)))

(defun close-program ()
  (interactive)
  (kill-buffer)
  (delete-frame))

(global-set-key (kbd "C-s-q") #'close-program)

(setq vterm-new--i 0)
(defun vterm-new ()
  (interactive)
  (vterm (setq vterm-new--i (1+ vterm-new--i))))

(defun cheat (name)
  (interactive "s")
  (eww (concat "https://cheat.sh/" name)))

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
			     (dot . t)))
;; (elpaca-use-package xah-fly-keys
  ;; :config
  ;; (xah-fly-keys-set-layout "qwerty"))

(elpaca-use-package ac-geiser)
(elpaca-use-package all-the-icons)
(elpaca-use-package all-the-icons-dired)
;(elpaca-use-package auctex)
(elpaca-use-package calfw)
(elpaca-use-package circe)
(elpaca-use-package company)
(elpaca-use-package company-box)
(elpaca-use-package crux)
(elpaca-use-package csv)
(elpaca-use-package csv-mode)
(elpaca-use-package dashboard)
(elpaca-use-package debbugs)
(elpaca-use-package direnv)
(elpaca-use-package ediprolog)
(elpaca-use-package elfeed)
(elpaca-use-package elpher)
(elpaca-use-package embark)
(elpaca-use-package ement)
(elpaca-use-package eshell-z)
(elpaca-use-package flycheck)
(elpaca-use-package flycheck-haskell)
(elpaca-use-package frames-only-mode)
(elpaca-use-package gdscript-mode)
(elpaca-use-package guix)
(elpaca-use-package haskell-mode)
(elpaca-use-package highlight-indent-guides)
(elpaca-use-package htmlize)
(elpaca-use-package iedit)
;(elpaca-use-package irony-eldoc)
;(elpaca-use-package irony-mode)
(elpaca-use-package lsp-ui)
(elpaca-use-package magit-todos)
(elpaca-use-package monokai-theme)
(elpaca-use-package multi-term)
(elpaca-use-package nix-mode)
(elpaca-use-package on-screen)
(elpaca-use-package org-superstar)
(elpaca-use-package ox-gemini)
;(elpaca-use-package parinfer)
(elpaca-use-package pdf-tools)
(elpaca-use-package pg)
(elpaca-use-package projectile)
(elpaca-use-package racket-mode)
(elpaca-use-package realgud)
(elpaca-use-package rustic)
(elpaca-use-package swiper)
(elpaca-use-package tldr)
;(elpaca-use-package vterm)
(elpaca-use-package xkcd)
(elpaca-use-package yaml-mode)
(elpaca-use-package yasnippet)
(elpaca-use-package yasnippet-snippets)
(elpaca-use-package zerodark-theme)
(elpaca-use-package gemini-mode)
(elpaca-use-package nov)
(elpaca-use-package dockerfile-mode)
(elpaca-use-package docker)

(defun flatpak-run ()
  (interactive)
  (async-shell-command
   (concat "flatpak run "
	   (completing-read
	    "Run Flatpak: "
	    (mapcar #'(lambda (q)
			(let ((stf
			       (-take 2 (split-string q "\t"))))
			  `(,(cadr stf) . ,(car stf)))
			)
		    (delete "" (split-string
				(shell-command-to-string "flatpak list --app")
				"\n")))))
   "flatpaks"))

(frames-only-mode 1)
(elpaca-use-package org)
(elpaca-use-package dmenu)
