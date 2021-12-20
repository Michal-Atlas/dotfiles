;;; package --- Summary
;;; Commentary:
;;; Code:
;; Variable Init

;; [[file:../dotfiles/conf.org::*Variable Init][Variable Init:1]]
(setq user-full-name "Michal Atlas"
      user-mail-address "michal.z.atlas@gmail.com")

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
(setq dashboard-startup-banner 'logo)
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

(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook #'indent-guide-global-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(set-frame-font "Jetbrains Mono-8" nil t)
(add-to-list 'default-frame-alist '(font . "Jetbrains Mono-8"))

(require 'doom-themes)
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-gruvbox t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(setq doom-themes-treemacs-theme "doom-gruvbox") ; use "doom-colors" for less minimal icon theme
(doom-themes-treemacs-config)
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

(require 'doom-modeline)
(doom-modeline-mode 1)

(require 'solaire-mode)
(solaire-global-mode +1)

(require 'which-key)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

(require 'company-box)
(add-hook 'company-mode-hook #'company-box-mode)

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

(require 'company)
(company-mode)
(add-hook 'after-init-hook #'global-company-mode)

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
(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

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
(global-set-key (kbd "C-;") 'embark-dwim)
(global-set-key (kbd "C-h B") 'embark-bindings)

;; Optionally replace the key help with a completing-read interface
(setq prefix-help-command #'embark-prefix-help-command)

;; Hide the mode line of the Embark live/completions buffers
(add-to-list 'display-buffer-alist
	     '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
	       nil
	       (window-parameters (mode-line-format . none))))

(require 'consult)

(global-set-key (kbd "C-c h") 'consult-history)
(global-set-key (kbd "C-c m") 'consult-mode-command)
(global-set-key (kbd "C-c b") 'consult-bookmark)
(global-set-key (kbd "C-c k") 'consult-kmacro)
;; C-x bindings (ctl-x-map)
(global-set-key (kbd "C-x M-:") 'consult-complex-command)     ;; orig. repeat-complex-command
(global-set-key (kbd "C-x b") 'consult-buffer)                ;; orig. switch-to-buffer
(global-set-key (kbd "C-x 4 b") 'consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
(global-set-key (kbd "C-x 5 b") 'consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
;; Custom M-# bindings for fast register access
(global-set-key (kbd "M-#") 'consult-register-load)
(global-set-key (kbd "M-'") 'consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
(global-set-key (kbd "C-M-#") 'consult-register)
;; Other custom bindings
(global-set-key (kbd "M-y") 'consult-yank-pop)                ;; orig. yank-pop
(global-set-key (kbd "<help> a") 'consult-apropos)            ;; orig. apropos-command
;; M-g bindings (goto-map)
(global-set-key (kbd "M-g e") 'consult-compile-error)
(global-set-key (kbd "M-g f") 'consult-flymake)               ;; Alternative: consult-flycheck
(global-set-key (kbd "M-g g") 'consult-goto-line)             ;; orig. goto-line
(global-set-key (kbd "M-g M-g") 'consult-goto-line)           ;; orig. goto-line
(global-set-key (kbd "M-g o") 'consult-outline)               ;; Alternative: consult-org-heading
(global-set-key (kbd "M-g m") 'consult-mark)
(global-set-key (kbd "M-g k") 'consult-global-mark)
(global-set-key (kbd "M-g i") 'consult-imenu)
(global-set-key (kbd "M-g I") 'consult-imenu-multi)
;; M-s bindings (search-map)
(global-set-key (kbd "M-s f") 'consult-find)
(global-set-key (kbd "M-s F") 'consult-locate)
(global-set-key (kbd "M-s g") 'consult-grep)
(global-set-key (kbd "M-s G") 'consult-git-grep)
(global-set-key (kbd "M-s r") 'consult-ripgrep)
(global-set-key (kbd "M-s l") 'consult-line)
(global-set-key (kbd "M-s L") 'consult-line-multi)
(global-set-key (kbd "M-s m") 'consult-multi-occur)
(global-set-key (kbd "M-s k") 'consult-keep-lines)
(global-set-key (kbd "M-s u") 'consult-focus-lines)
;; Isearch integration
(global-set-key (kbd "M-s e") 'consult-isearch-history)
:map isearch-mode-map
(global-set-key (kbd "M-e") 'consult-isearch-history)         ;; orig. isearch-edit-string
(global-set-key (kbd "M-s e") 'consult-isearch-history)       ;; orig. isearch-edit-string
(global-set-key (kbd "M-s l") 'consult-line)                  ;; needed by consult-line to detect isearch
(global-set-key (kbd "M-s L") 'consult-line-multi)           ;; needed by consult-line to detect isearch

;; Enable automatic preview at point in the *Completions* buffer.
;; This is relevant when you use the default completion UI,
;; and not necessary for Vertico, Selectrum, etc.
(add-hook 'completion-list-mode #'consult-preview-at-point-mode)

;; Optionally configure the register formatting. This improves the register
;; preview for `consult-register', `consult-register-load',
;; `consult-register-store' and the Emacs built-ins.
(setq register-preview-delay 0
      register-preview-function #'consult-register-format)

;; Optionally tweak the register preview window.
;; This adds thin lines, sorting and hides the mode line of the window.
(advice-add #'register-preview :override #'consult-register-window)

;; Optionally replace `completing-read-multiple' with an enhanced version.
(advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

;; Use Consult to select xref locations with preview
(setq xref-show-xrefs-function #'consult-xref
      xref-show-definitions-function #'consult-xref)

;; Configure other variables and modes in the :config section,
;; after lazily loading the package.

;; Optionally configure preview. The default value
;; is 'any, such that any key triggers the preview.
;; (setq consult-preview-key 'any)
;; (setq consult-preview-key (kbd "M-."))
;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
;; For some commands and buffer sources it is useful to configure the
;; :preview-key on a per-command basis using the `consult-customize' macro.
(consult-customize
 consult-theme
 :preview-key '(:debounce 0.2 any)
 consult-ripgrep consult-git-grep consult-grep
 consult-bookmark consult-recent-file consult-xref
 consult--source-file consult--source-project-file consult--source-bookmark
 :preview-key (kbd "M-."))

;; Optionally configure the narrowing key.
;; Both < and C-+ work reasonably well.
(setq consult-narrow-key "<") ;; (kbd "C-+")

;; Optionally make narrowing help available in the minibuffer.
;; You may want to use `embark-prefix-help-command' or which-key instead.
;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

;; Optionally configure a function which returns the project root directory.
;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (project-roots)
(setq consult-project-root-function
      (lambda ()
	(when-let (project (project-current))
	  (car (project-roots project)))))
  ;;;; 2. projectile.el (projectile-project-root)
;; (autoload 'projectile-project-root "projectile")
;; (setq consult-project-root-function #'projectile-project-root)
  ;;;; 3. vc.el (vc-root-dir)
;; (setq consult-project-root-function #'vc-root-dir)
  ;;;; 4. locate-dominating-file
;; (setq consult-project-root-function (lambda () (locate-dominating-file "." ".git")))

;; Embark and Consult:1 ends here

;; Langs

;; Guile

(ac-config-default)
(require 'ac-geiser)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(eval-after-load "auto-complete")
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

(provide 'init)
;;; init.el ends here

(require 'frames-only-mode)
(frames-only-mode 1)
