(setq debug-on-error t)
;; ELPACA SETUP
(defvar elpaca-installer-version 0.3)
(defvar elpaca-directory
  (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory
  (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory
  (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order
  '(elpaca
    :repo "https://github.com/progfolio/elpaca.git"
    :ref nil
    :files (:defaults (:exclude "extensions"))
    :build (:not elpaca--activate-package)))
(let* ((repo (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list
   'load-path
   (if (file-exists-p build)
       build
     repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (condition-case-unless-debug err
        (if-let ((buffer
                  (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop
                   (call-process "git"
                                 nil
                                 buffer
                                 t
                                 "clone"
                                 (plist-get order :repo)
                                 repo)))
                 ((zerop
                   (call-process "git"
                                 nil
                                 buffer
                                 t
                                 "checkout"
                                 (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop
                   (call-process
                    emacs
                    nil
                    buffer
                    nil
                    "-Q"
                    "-L"
                    "."
                    "--batch"
                    "--eval"
                    "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
          (kill-buffer buffer)
          (error
           "%s"
           (with-current-buffer buffer
             (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))
;; END ELPACA SETUP

;; Install use-package support
(elpaca
 elpaca-use-package
 ;; Enable :elpaca use-package keyword.
 (elpaca-use-package-mode)
 ;; Assume :elpaca t unless otherwise specified.
 (setq elpaca-use-package-by-default t))

(elpaca-wait)

;; Org-mode

;; (use-package org-fragtog
;;   :hook (org-mode org-fragtog-mode))
(use-package org-modern :hook (org-mode . org-modern-mode))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t) (scheme . t) (dot . t) (lisp . t)))

;; Variable Init

(setq
 user-full-name "Michal Atlas"
 user-mail-address "michal_atlas+emacs@posteo.net")
;; (setq user-full-name "Michal Žáček"
;;       user-mail-address "zacekmi2@fit.cvut.cz"

(setq mastodon-instance-url "https://lgbtcz.social")
(setq mastodon-active-user "michal_atlas")
(setq indent-tabs-mode nil)

(setq backup-directory-alist '((".*" . "~/.emacs.d/bkp")))
(setq projectile-project-search-path
      (list "~/Documents" "~/source" "~/cl"))
(setq org-roam-directory "/home/michal_atlas/roam")
(setq enable-local-variables :all)
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

(defun yes-or-no-p (prompt)
  (y-or-n-p prompt))
;(dired-async-mode 1)
(setq auth-sources '("~/.authinfo.gpg"))

(setq inferior-lisp-program "ros -Q run")

;; Scrolling

(setq
 scroll-step 1
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


(use-package
 highlight-indentation
 :hook (prog-mode . highlight-indentation-mode)
 :custom (highlight-indent-guides-method 'bitmap))

(defvar font-code "Fira Code 12")
(set-frame-font font-code nil t)
;; Loads font when opening new frames
(add-to-list 'default-frame-alist `(font . ,font-code))
;; (use-package fira-code-mode :config (global-fira-code-mode))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; (use-package mode-icons :config (mode-icons-mode 1))
;; (elpaca-wait)
(use-package direnv :config (direnv-mode t))

;; Theme

;; (setq
;;  modus-themes-subtle-line-numbers t
;;  modus-themes-mode-line '(accented)
;;  modus-themes-syntax '(yellow-comments)
;;  modus-themes-paren-match '(bold intense)
;;  modus-themes-prompts '(intense)
;;  modus-themes-region '(no-extend bg-only accented)
;;  modus-themes-bold-constructs t
;;  modus-themes-hl-line '(accented intense))
;; (use-package gruvbox-theme :config (load-theme 'gruvbox-dark-hard t))
(use-package monokai-theme :config (load-theme 'monokai t))

;; Modeline

(use-package doom-modeline :init (doom-modeline-mode 1))

;; Completion

(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Tramp

(setq tramp-default-method "ssh")

;; Packages 

(use-package which-key :config (which-key-mode))
(setq which-key-popup-type 'minibuffer)

(use-package
 rainbow-identifiers
 :hook (prog-mode . rainbow-identifiers-mode))
(use-package
 rainbow-delimiters
 :hook (prog-mode . rainbow-delimiters-mode))

(set-default 'preview-scale-function 1.5)

(use-package
 undo-tree
 :config
 (global-undo-tree-mode 1)
 (setq undo-tree-auto-save-history t)
 (setq undo-tree-history-directory-alist
       '(("." . "~/.emacs.d/undo"))))

(use-package ace-window :bind ("M-o" . ace-window))


;; Eshell

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

;; LSP

(use-package
  lsp-mode
  :bind ("C-c c" . compile)
  :custom (lsp-keymap-prefix "C-c l")
  :hook
  (lsp-mode . lsp-enable-which-key-integration)
  (c-mode . lsp)
  (c++-mode . lsp))


(global-set-key (kbd "C-c o c") 'cfw:open-calendar-buffer)

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

(setq org-agenda-files '("~/roam/todo.org"))

;; Roam

;; (use-package org-roam
;;   :custom
;;   (org-roam-directory (file-truename "~/roam/"))
;;   (org-roam-capture-templates
;;    '(
;;      ("d" "default" plain "%?" :target
;;       (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
;;   ")
;;       :unnarrowed t)
;;      ("p" "people" plain "%?" :target
;;       (file+head "people/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
;;   ")
;;       :unnarrowed t)
;;      ("f" "food" plain "%?" :target
;;       (file+head "food/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}
;;   ")
;;       :unnarrowed nil)
;;      ))
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;; 	 ("C-c n f" . org-roam-node-find)
;; 	 ("C-c n g" . org-roam-graph)
;; 	 ("C-c n i" . org-roam-node-insert)
;; 	 ("C-c n c" . org-roam-capture)
;; 	 ;; Dailies
;; 	 ("C-c n j" . org-roam-dailies-capture-today))
;;   :config
;;   ;; If you're using a vertical completion framework, you might want a more informative completion interface
;;   (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;   (org-roam-db-autosync-mode)
;;   ;; If using org-roam-protocol
;;   (require 'org-roam-protocol))
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

(use-package auto-complete :config (ac-config-default))

(use-package geiser :hook (scheme-mode geiser-mode))

(use-package
 geiser-guile
 :config
 (add-hook 'geiser-mode-hook 'ac-geiser-setup)
 (add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
 (add-to-list 'ac-modes' geiser-repl-mode))

(use-package
 paredit
 :hook
 ((emacs-lisp-mode . paredit-mode)
  ;; (eval-expression-minibuffer-setup . paredit-mode)
  (scheme-mode . paredit-mode) (lisp-mode . paredit-mode)))

(use-package
 multiple-cursors
 :bind
 (("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)))

;; C

(add-hook 'shell-script-mode 'prog-mode)

;; Elfeed

(setq
 elfeed-feeds
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
   ("https://lexfridman.com/feed/podcast/")))

;; Misc

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
; (use-package helpful
;   :bind (("C-h f" . helpful-function)
;	 ("C-h k" . helpful-key)))

(use-package avy :bind ("C-c q" . avy-goto-char-timer))
(use-package
 browse-kill-ring
 :config (browse-kill-ring-default-keybindings))


;; EMMS

(use-package
 emms
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
  emms-player-mpv-parameters
  '("--quiet"
    "--really-quiet"
    "--no-video"
    "--no-audio-display"
    "--force-window=no"
    "--vo=null")))

;; Thaumiel 

;      (straight-use-package '(thaumiel :local-repo "thaumiel" :repo "michal_atlas/thaumiel"))

;; Matrix


;; Evil

;; (use-package evil
;;   :config (evil-mode 1))

(use-package
 tramp
 :elpaca nil
 :config
 (connection-local-set-profile-variables
  'guix-system '((tramp-remote-path . (tramp-own-remote-path))))

 (setq tramp-remote-path
       (append tramp-remote-path '(tramp-own-remote-path)))

 (connection-local-set-profiles
  `(:application
    tramp
    :protocol "sudo"
    :machine ,(system-name))
  'guix-system))

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
    "Brightness..."
    (string-trim (shell-command-to-string "light -G"))
    "%")))

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
   (funcall (-cut string-join <> (string ?\n))
            (mapcar
             (-compose #'string-trim #'shell-command-to-string)
             '("pactl get-sink-mute @DEFAULT_SINK@"
               "pactl get-sink-volume @DEFAULT_SINK@")))))

(defun player/play ()
  (interactive)
  (shell-command "playerctl play-pause"))
(defun player/next ()
  (interactive)
  (shell-command "playerctl next"))
(defun player/prev ()
  (interactive)
  (shell-command "playerctl previous"))

(global-set-key
 (kbd "s-<return>")
 (lambda ()
   (interactive)
   (start-process-shell-command "kitty" nil "kitty")))

(use-package embark :bind ("C-." . embark-act))
(use-package embark-consult)

;; EXWM

;; (use-package exwm
;;   :custom
;;   (exwm-workspace-number 10)
;;   :bind
;;   ("C-M-l" . (lambda () (interactive) (shell-command "slock")))
;;   :config
;;   (add-hook 'exwm-update-class-hook
;; 	    (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
;;   (require 'exwm-systemtray)
;;   (exwm-systemtray-enable)
;;   (set-frame-parameter (selected-frame) 'alpha '(85 . 85))
;;   (add-to-list 'default-frame-alist '(alpha . (85 . 85)))
;;   (dolist (cmd '("nm-applet" "pasystray" ("xss-lock" . "xss-lock -- slock")))
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
;;      ([?\C-k] . [S-end delete])
;;      ([?\C-s] . [C-f]))

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

(use-package
 vertico
 :init (vertico-mode)
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
(use-package
 consult
 :bind
 (("C-x b" . consult-buffer)
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

;; (use-package xah-fly-keys
;; :config
;; (xah-fly-keys-set-layout "qwerty"))

;; (use-package frames-only-mode
;;   :config (frames-only-mode 1))

(defun flatpak-run ()
  (interactive)
  (async-shell-command (concat
                        "flatpak run "
                        (completing-read
                         "Run Flatpak: "
                         (mapcar
                          #'(lambda (q)
                              (let ((stf
                                     (-take 2 (split-string q "\t"))))
                                `(,(cadr stf) . ,(car stf))))
                          (delete
                           ""
                           (split-string (shell-command-to-string
                                          "flatpak list --app")
                                         "\n")))))
                       "flatpaks"))

(use-package hydra)
(elpaca-wait)
(defhydra
 hydra-system
 (global-map "C-c s")
 "system"
 ("p" player/play "Play")
 ("o" player/next "Next")
 ("i" player/prev "Prev")
 ("e" light/up "Br. Up")
 ("d" light/down "Br. Down")
 ("r" volume/up "Vol. Up")
 ("f" volume/down "Vol. Down")
 ("m" volume/mute "Mute"))

(defhydra
 hydra-launcher
 (global-map "C-c r" :color purple :exit t)
 "Launch"
 ("r" (browse-url "http://www.reddit.com/r/emacs/") "reddit")
 ("w" (browse-url "http://www.emacswiki.org/") "emacswiki")
 ("f" (start-process-shell-command "firefox" nil "firefox") "firefox")
 ("d" (start-process-shell-command
   "discord" nil "flatpak run com.discordapp.Discord")
  "discord")
 ("s" shell "shell")
 ("e" eshell "eshell")
 ("l"
  (start-process-shell-command "lagrange" nil "lagrange")
  "lagrange")
 ("g" guix-packages-by-name "find package")
 ("q" nil "cancel"))

(defhydra
 hydra-buffer
 (global-map "C-x")
 ("<right>" next-buffer)
 ("<left>" previous-buffer))

;; Guile scripts

(setq guile-script-path '("~/dotfiles/scripts"))

(defun guile/script-launcher ()
  (interactive)
  (print
   (let* ((script-list
           (peek
            (mapcar
             (lambda (q) `(,(f-filename q) . ,q))
             (apply #'append
                    (mapcar
                     (lambda (q)
                       (directory-files
                        q
                        t directory-files-no-dot-files-regexp))
                     guile-script-path)))))
          (comp (completing-read "Run Script: " script-list)))
     (async-shell-command (alist-get comp script-list nil nil #'equal)
                          (concat "guile:" comp)))))

(defun peek (x)
  (print x)
  x)

(use-package frame :elpaca nil :bind ("C-z" . nil))

(use-package adaptive-wrap)
(use-package all-the-icons)
(use-package all-the-icons-dired)
;; (use-package tex :ensure auctex)
(use-package calfw)
(use-package circe)
(use-package company)
;; (use-package company-box)
(use-package consult-org-roam)
(use-package consult-yasnippet)
(use-package crux)
(use-package csv)
(use-package csv-mode)
(use-package dashboard)
;; (use-package debbugs)
(use-package dmenu)
(use-package docker)
(use-package dockerfile-mode)
(use-package ediprolog)
(use-package eglot)
(use-package elpher)
(use-package ement)
(use-package engrave-faces)
(use-package flycheck)
(use-package flycheck-haskell)
(use-package gdscript-mode)
(use-package gemini-mode)
(use-package go-mode)
(use-package haskell-mode)
(use-package htmlize)
(use-package iedit)
(use-package lsp-ui)
(use-package magit-todos)
(use-package multi-term)
(use-package nix-mode)
(use-package nixos-options)
(use-package nov)
(use-package on-screen)
(use-package org-superstar)
(use-package ox-gemini)
(use-package password-generator)
(use-package password-store)
(use-package password-store-otp)
(use-package pdf-tools)
(use-package realgud)
(use-package rustic)
(use-package sly)
(use-package stumpwm-mode)
(use-package swiper)
(use-package tldr)
(use-package yaml-mode)
(use-package yasnippet)
(use-package yasnippet-snippets)
(use-package zerodark-theme)
(use-package elisp-autofmt)
(use-package slime)
(use-package elvish-mode)
(use-package ob-elvish)
(use-package eshell-z)

;; (use-package
;;  aweshell
;;  :elpaca
;;  (abc-mode :fetcher github :repo "manateelazycat/aweshell"))

(defun init-unlink ()
  (interactive)
  (f-delete "~/.emacs.d/init.el")
  (f-symlink
   (expand-file-name "~/cl/dotfiles/home/dotfiles/emacs.el")
   "~/.emacs.d/init.el"))

(use-package pretty-sha-path :config (global-pretty-sha-path-mode))

(use-package request)
(use-package cheat-sh)
(use-package keychain-environment
  :config (keychain-refresh-environment))
