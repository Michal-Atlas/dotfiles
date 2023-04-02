;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-peacock)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Org-mode

;; (use-package org-fragtog
;;   :hook (org-mode org-fragtog-mode))
(use-package! org-modern :hook (org-mode . org-modern-mode))
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

;; Completion

(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Tramp

(setq tramp-default-method "ssh")

;; Packages

(use-package!
 rainbow-identifiers
 :hook (prog-mode . rainbow-identifiers-mode))
(use-package!
 rainbow-delimiters
 :hook (prog-mode . rainbow-delimiters-mode))

(set-default 'preview-scale-function 1.5)

;; Eshell

(use-package!
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
(use-package!
 eshell-syntax-highlighting
 :config (eshell-syntax-highlighting-global-mode 1))
(setq eshell-review-quick-commands nil)
(require 'esh-module) ; require modules
(add-to-list 'eshell-modules-list 'eshell-tramp)
;; (use-package!
;;  esh-autosuggest
;;  :hook (eshell-mode . esh-autosuggest-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.

;(use-package! savehist :init (savehist-mode))

;; Configure directory extension.

(setq org-agenda-files '("~/roam/todo.org"))

;; Roam

;; (use-package! org-roam
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
;; (use-package! org-roam-ui
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

(use-package!
 paredit
 :hook
 ((emacs-lisp-mode . paredit-mode)
  ;; (eval-expression-minibuffer-setup . paredit-mode)
  (scheme-mode . paredit-mode) (lisp-mode . paredit-mode)))

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

;; EMMS

(use-package!
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

;      (straight-use-package! '(thaumiel :local-repo "thaumiel" :repo "michal_atlas/thaumiel"))

;; Matrix


;; Evil


(use-package!
 tramp
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

;; EXWM

;; (use-package! exwm
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

(defun close-program ()
  (interactive)
  (kill-buffer)
  (delete-frame))

(setq vterm-new--i 0)
(defun vterm-new ()
  (interactive)
  (vterm (cl-incf vterm-new--i)))

;; (use-package! xah-fly-keys
;; :config
;; (xah-fly-keys-set-layout "qwerty"))

;; (use-package! frames-only-mode
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

(use-package! frame :bind ("C-z" . nil))

;; (use-package!
;;  aweshell
;;  :elpaca
;;  (abc-mode :fetcher github :repo "manateelazycat/aweshell"))

(defun init-unlink ()
  (interactive)
  (f-delete "~/.emacs.d/init.el")
  (f-symlink
   (expand-file-name "~/cl/dotfiles/home/dotfiles/emacs.el")
   "~/.emacs.d/init.el"))

(use-package! pretty-sha-path :config (global-pretty-sha-path-mode))

(use-package! request)
(use-package! cheat-sh)
(use-package! keychain-environment
  :config (keychain-refresh-environment))
