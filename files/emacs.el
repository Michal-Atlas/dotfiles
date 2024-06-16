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

(use-package
 highlight-indentation
 :hook (prog-mode . highlight-indentation-mode)
 :custom (highlight-indent-guides-method 'bitmap))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

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
