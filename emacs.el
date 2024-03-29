;;; package --- Summary
;;; Commentary:
;;; Code:
;; Variable Init

;; (setq user-full-name "Michal Atlas"
;;       user-mail-address "michal.z.atlas@gmail.com")
(setq user-full-name "Michal Žáček"
      user-mail-address "zacekmi2@fit.cvut.cz")

(setq backup-directory-alist '((".*" . "~/.emacs.d/bkp")))
(setq org-directory "~/Documents/")
(setq projectile-project-search-path (list "~/Documents" "~/source"))
(setq org-agenda-files "~/Documents/agenda.list")
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

;; Dashboard

(setq dashboard-projects-backend 'projectile)
(setq dashboard-items '((recents  . 7)
			(bookmarks . 5)
			(projects . 7)
			(agenda . 5)
			(registers . 5)))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-banner-logo-title "Atlas Emacs")
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

(add-hook 'prog-mode-hook #'highlight-indent-guides-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(setq highlight-indent-guides-method 'bitmap)

(set-frame-font "Fira Code-8" nil t)
(add-to-list 'default-frame-alist '(font . "Fira Code-8"))

(load-theme 'gruvbox t)
(doom-modeline-mode 1)
(solaire-global-mode +1)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(add-hook 'prog-mode-hook #'rainbow-identifiers-mode)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(set-default 'preview-scale-function 1.5)

;; Formatting

(global-aggressive-indent-mode 1)

(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

;; Company

;; 
;; (company-mode)
;; (add-hook 'after-init-hook #'global-company-mode)

;; 
;; (add-hook 'company-mode-hook #'company-box-mode)
;; (setq company-box-icons-alist 'company-box-icons-all-the-icons)

(global-flycheck-mode)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Vertico

(vertico-mode)
(setq vertico-count 15)

(setq completion-styles '(orderless)
      completion-category-defaults nil
      completion-category-overrides '((file (styles partial-completion))))

(setq enable-recursive-minibuffers t)

;; LSP

(global-set-key (kbd "C-c c") 'compile)

(setq lsp-keymap-prefix "C-c l")
(add-hook 'lsp-mode-hook       #'lsp-enable-which-key-integration)

;; Magit

(global-set-key (kbd "C-c v s") 'magit-stage)
(global-set-key (kbd "C-c v p") 'magit-push)
(global-set-key (kbd "C-c v f") 'magit-pull)
(global-set-key (kbd "C-c v c") 'magit-commit)

(global-set-key (kbd "C-c o c") 'cfw:open-calendar-buffer)

(add-hook 'dired-mode-hook #'all-the-icons-dired-mode)

(global-git-gutter-mode +1)

(add-hook 'org-mode-hook #'org-fragtog-mode)

(global-set-key (kbd "M-q") 'avy-goto-word-0)

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
   (scheme . t)
   ))

(add-hook 'org-mode-hook #'org-superstar-mode)

(marginalia-mode)

;; Embark and Consult

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

(ac-config-default)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(add-to-list 'ac-modes' geiser-repl-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

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
	("https://akce.cvut.cz/?node=rss&group=7" ctu)
	("https://akce.cvut.cz/?node=rss&group=11" ctu)
	("https://aktualne.cvut.cz/rss/newsflashes" ctu)
	("http://festivalofthespokennerd.libsyn.com/rss" podcast)
	("https://konfery.cz/rss/")
	("https://guix.gnu.org/feeds/blog.atom")))

(provide 'init)
