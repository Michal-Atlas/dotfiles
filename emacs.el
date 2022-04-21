;;; package --- Summary
;;; Commentary:
;;; Code:
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
;; Variable Init:1 ends here

(defun yes-or-no-p (prompt) (y-or-n-p prompt))

;; Theming

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(column-number-mode 1)

(add-hook 'prog-mode-hook #'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'bitmap)

(set-frame-font "Fira Code-11" nil t)
(add-to-list 'default-frame-alist '(font . "Fira Code-11"))

(load-theme 'zerodark t)
(zerodark-setup-modeline-format)
(solaire-global-mode +1)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

(global-display-line-numbers-mode)
(global-hl-line-mode 1)

(add-hook 'prog-mode-hook #'rainbow-identifiers-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(set-default 'preview-scale-function 1.5)

(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

(guix-prettify-global-mode +1)

;; Eshell

(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

(defun eshell-new()
  "Open a new instance of eshell."
  (interactive)
  (eshell 'N))

(add-hook 'eshell-mode-hook
	  (defun my-eshell-mode-hook ()
	    (require 'eshell-z)))

(require 'eshell)
(eshell-syntax-highlighting-global-mode 1)
(setq eshell-review-quick-commands nil)
(require 'esh-module) ; require modules
(add-to-list 'eshell-modules-list 'eshell-tramp)
(require 'equake)
(advice-add #'save-buffers-kill-terminal :before-while #'equake-kill-emacs-advice)
(require 'esh-autosuggest)
(add-hook 'eshell-mode-hook #'esh-autosuggest-mode)

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
(add-hook 'org-mode-hook #'org-superstar-mode)

(avy-setup-default)
(global-set-key (kbd "C-:") 'avy-goto-char-timer)

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

;; Lisps

(ac-config-default)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(add-to-list 'ac-modes' geiser-repl-mode)

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(add-hook 'common-lisp-mode-hook #'slime-mode)
(add-hook 'scheme-mode-hook #'geiser-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'aggressive-indent-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook 'common-lisp-mode-hook           #'enable-paredit-mode)

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
	("https://akce.cvut.cz/?node=rss&group=7" ctu)
	("https://akce.cvut.cz/?node=rss&group=11" ctu)
	("https://aktualne.cvut.cz/rss/newsflashes" ctu)
	("http://festivalofthespokennerd.libsyn.com/rss" podcast)
	("https://konfery.cz/rss/")
	("https://guix.gnu.org/feeds/blog.atom")))

(provide 'init)
