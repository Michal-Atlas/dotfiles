;;; package --- Summary
;;; Commentary:
;;; Code:
;; Variable Init

(setq user-full-name "Michal Atlas"
      user-mail-address "michal.z.atlas@gmail.com")

(add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp")
(setq backup-directory-alist '((".*" . "~/.emacs.d/bkp")))
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

;; Dashboard

(setq dashboard-projects-backend 'projectile)
(setq dashboard-items '((recents  . 7)
			(bookmarks . 5)
			(projects . 7)
			(agenda . 5)
			(registers . 5)))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-banner-logo-title "Atlas Emacs")
(setq dashboard-startup-banner "~/.guix-profile/share/emacs-guix/images/guix-logo.svg")
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-set-init-info t)
(setq dashboard-week-agenda t)
(setq dashboard-center-content t)
(dashboard-setup-startup-hook)

;; Theming

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)

(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook #'highlight-indent-guides-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setq highlight-indent-guides-method 'bitmap)

(set-frame-font "Jetbrains Mono-8" nil t)
(add-to-list 'default-frame-alist '(font . "Jetbrains Mono-8"))

(require 'spacemacs-dark-theme)
(load-theme 'spacemacs-dark t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
(doom-themes-org-config)

(require 'doom-modeline)
(doom-modeline-mode 1)

(require 'solaire-mode)
(solaire-global-mode +1)

(require 'which-key)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(require 'rainbow-identifiers)
(add-hook 'prog-mode-hook #'rainbow-identifiers-mode)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Theming:1 ends here

;; Formatting

(require 'aggressive-indent)
(global-aggressive-indent-mode 1)

;; Formatting:1 ends here

(require' crux)

(require 'undo-tree)
(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

;; Company

;; (require 'company)
;; (company-mode)
;; (add-hook 'after-init-hook #'global-company-mode)

;; (require 'company-box)
;; (add-hook 'company-mode-hook #'company-box-mode)
;; (setq company-box-icons-alist 'company-box-icons-all-the-icons)

(require 'flycheck)
(global-flycheck-mode)

;; Company:1 ends here

(require 'yasnippet)
(yas-global-mode 1)

(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Vertico

;; [[file:../dotfiles/conf.org::*Vertico][Vertico:1]]
;; Enable vertico
(require 'vertico)
(vertico-mode)
(setq vertico-count 15)


(require 'orderless)
(setq completion-styles '(orderless)
      completion-category-defaults nil
      completion-category-overrides '((file (styles partial-completion))))

(setq enable-recursive-minibuffers t)

;; Vertico:1 ends here

;; LSP

(global-set-key (kbd "C-c c") 'compile)
(require 'lsp-mode)
(setq lsp-keymap-prefix "C-c l")
(add-hook 'lsp-mode-hook       #'lsp-enable-which-key-integration)

(require 'lsp-ui)

;; LSP:1 ends here

;; Magit

(require 'magit)
(global-set-key (kbd "C-c v s") 'magit-stage)
(global-set-key (kbd "C-c v p") 'magit-push)
(global-set-key (kbd "C-c v f") 'magit-pull)
(global-set-key (kbd "C-c v c") 'magit-commit)

(require 'magit-todos)

;; Magit:1 ends here

(require 'guix)
(require 'adaptive-wrap)
(require 'calfw)
(require 'calfw-org)
(global-set-key (kbd "C-c o c") 'cfw:open-calendar-buffer)
(require 'pdf-tools)
(require 'all-the-icons-dired)
(add-hook 'dired-mode-hook #'all-the-icons-dired-mode)
(require 'git-gutter)
(global-git-gutter-mode +1)
(require 'org-fragtog)
(add-hook 'org-mode-hook #'org-fragtog-mode)
(require 'avy)
(global-set-key (kbd "M-q") 'avy-goto-word-0)
(require 'anzu)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; Org Mode

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (dot . t)
   (C . t)
   (shell . t)
   ))

(require 'org-present)
(require 'org-superstar)
(add-hook 'org-mode-hook #'org-superstar-mode)

;; Org Mode:1 ends here

;; Marginalia

;; Enable richer annotations using the Marginalia package
(require 'marginalia)
(marginalia-mode)

;; Marginalia:1 ends here

;; Embark and Consult

(require 'embark)
(global-set-key (kbd "C-.") 'embark-act)
(global-set-key (kbd "C-\"") 'embark-dwim)
(global-set-key (kbd "C-h B") 'embark-bindings)

;; Optionally replace the key help with a completing-read interface
(setq prefix-help-command #'embark-prefix-help-command)

;; Hide the mode line of the Embark live/completions buffers
(add-to-list 'display-buffer-alist
	     '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
	       nil
	       (window-parameters (mode-line-format . none))))

;; Langs

;; Guile

(require 'ac-geiser)
(ac-config-default)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(add-to-list 'ac-modes' geiser-repl-mode)

(require 'paredit)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

(require 'iedit)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; C

(require' irony)
(add-hook 'c-mode-hook #'irony-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'irony-mode)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'irony-mode-hook #'irony-cdb-autosetup-compile-options)
(require 'irony-eldoc)
(add-hook 'irony-mode-hook #'irony-eldoc)
;; C:1 ends here

(add-hook 'shell-script-mode 'prog-mode)

;; Elfeed

(require 'elfeed)
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2b9dc43b786e36f68a9fd4b36dd050509a0e32fe3b0a803310661edb7402b8b6" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" default)))

(provide 'init)
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
