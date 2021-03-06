;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

(setq user-emacs-directory "~/.emacs.d")

;; Set path to dependencies
(setq site-lisp-dir
	  (expand-file-name "site-lisp" user-emacs-directory))
(setq settings-dir
	  (expand-file-name "settings" user-emacs-directory))
;;(setq custom-theme-load-path
;;      (expand-file-name "themes" user-emacs-directory))

;; ;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)
;;
;; ;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
;;
;; ;; Set up appearance early
(require 'appearance)
;;
;; ;; Settings for currently logged in user
;; (setq user-settings-dir
;;       (concat user-emacs-directory "users/" user-login-name))
;; (add-to-list 'load-path user-settings-dir)
;;
;; ;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
	(add-to-list 'load-path project)))
;;
;; ;; Write backup files to own directory
(require 'setup-backups)
(require 'setup-zoom)
;;
;; ;; Make backups of files, even when they're in version control
;; (setq vc-make-backup-files t)
;;
;; ;; Save point position between sessions
;; (require 'saveplace)
;; (setq-default save-place t)
;; (setq save-place-file (expand-file-name ".places" user-emacs-directory))
;;
;; ;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))
;;

(require 'setup-package)
;; ;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(circe
	 magit
	 paredit
	 move-text
	 gist
	 htmlize
	 visual-regexp
	 markdown-mode
	 fill-column-indicator
	 find-file-in-project
	 flycheck
	 flycheck-pos-tip
	 flycheck-clojure
	 flx
	 f
	 flx-ido
	 dired-details
	 css-eldoc
	 yasnippet
	 smartparens
	 ido-vertical-mode
	 ido-at-point
	 ido-completing-read+
	 simple-httpd
	 guide-key
	 nodejs-repl
	 restclient
	 highlight-escape-sequences
	 whitespace-cleanup-mode
	 elisp-slime-nav
	 dockerfile-mode
	 clojure-mode
	 clojure-mode-extra-font-locking
	 groovy-mode
	 prodigy
	 cider
	 string-edit
	 zencoding-mode
	 zenburn-theme
	 handlebars-mode
	 handlebars-sgml-mode
	 company
	 go-mode
	 go-guru
	 go-playground
	 go-scratch
	 corral
	 kotlin-mode
	 neotree
	 yaml-mode
	 vue-mode
	 vue-html-mode
	 undo-tree
	 recentf
	 zoom-window
	 go-gen-test
	 go-imenu
	 go-complete
	 )))

(condition-case nil
	(init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))


(require 'setup-env)
(require 'setup-ido)

;; ;; Lets start with a smattering of sanity
;; (require 'sane-defaults)
;;
;; ;; Setup environment variables from the user's shell.
;; (when is-mac
;;   (require-package 'exec-path-from-shell)
;;   (exec-path-from-shell-initialize))
;;
;; ;; guide-key
;; (require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
;; (guide-key-mode 1)
;; (setq guide-key/recursive-key-sequence-flag t)

;; (setq guide-key/popup-window-position 'bottom)
;;
;; ;; Setup extensions
;;
;; (eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'org '(require 'setup-org))
;; (eval-after-load 'dired '(require 'setup-dired))
(eval-after-load 'magit '(require 'setup-magit))
;; (eval-after-load 'grep '(require 'setup-rgrep))
;; (eval-after-load 'shell '(require 'setup-shell))
;; (require 'setup-hippie)
;; (require 'setup-yasnippet)
;; (require 'setup-perspective)
(require 'setup-ffip)
(require 'setup-sudo-save)
;; (require 'setup-html-mode)
;; (require 'setup-paredit)
;; (require 'setup-neotree)
;; (require 'setup-circe)
;; (require 'prodigy)
;; (global-set-key (kbd "C-x M-m") 'prodigy)
;;
;; ;; Font lock dash.el
;; (eval-after-load "dash" '(dash-enable-font-lock))
;;
;; ;; Default setup of smartparens
;; (require 'smartparens-config)
;; (setq sp-autoescape-string-quote nil)
;; (--each '(css-mode-hook
;;           restclient-mode-hook
;;           js-mode-hook
;;           java-mode
;;           ruby-mode
;;           markdown-mode
;;           groovy-mode
;;           scala-mode)
;;	(add-hook it 'turn-on-smartparens-mode))

;;
;; (global-auto-complete-mode)
;;
;; ;; Language specific setup files
;; (eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
;; (eval-after-load 'clojure-mode '(require 'setup-clojure-mode))
(eval-after-load 'markdown-mode '(require 'setup-markdown-mode))
(eval-after-load 'go-mode '(require 'setup-go-mode))
(eval-after-load 'purescript-mode '(require 'setup-purescript-mode))
(eval-after-load 'python-mode '(require 'setup-python-mode))
;; (eval-after-load 'typescript-mode '(require 'setup-tide-mode))
;;
;; >;; Load stuff on demand
;; (autoload 'skewer-start "setup-skewer" nil t)
;; (autoload 'skewer-demo "setup-skewer" nil t)
;; (autoload 'auto-complete-mode "auto-complete" nil t)
(eval-after-load 'flycheck '(require 'setup-flycheck))
;; (global-flycheck-mode)
;;
;; ;; Map files to modes
;; (require 'mode-mappings)
;;
;; ;; Highlight escape sequences
;; (require 'highlight-escape-sequences)
;; (hes-mode)
;; (put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)
;;
;; ;; Visual regexp
;; (require 'visual-regexp)
;; (define-key global-map (kbd "M-&") 'vr/query-replace)
;; (define-key global-map (kbd "M-/") 'vr/replace)
;;
;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
	(load file)))
;;
;; (require 'expand-region)
;; (require 'multiple-cursors)
;; (require 'delsel)
;; (require 'jump-char)
;; (require 'eproject)
;; (require 'wgrep)
;; (require 'smart-forward)
;; (require 'change-inner)
;; (require 'multifiles)
;;
;; ;; Don't use expand-region fast keys
;; (setq expand-region-fast-keys-enabled nil)
;;
;; ;; Show expand-region command used
;; (setq er--show-expansion-message t)
;;
;; ;; Fill column indicator
;; (require 'fill-column-indicator)
;; (setq fci-rule-color "#111122")
;;
;; ;; Browse kill ring
;; (require 'browse-kill-ring)
;; (setq browse-kill-ring-quit-action 'save-and-restore)
;;
;; ;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; TODO put this in a settings file
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(delete-selection-mode 1)

;;
;; ;; Setup key bindings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8) ; Assuming you want your tabs to be four/2 spaces wide
;; (setq tab-stop-list (number-sequence 2 200 2))
;;
;;					;(setq indent-line-function 'insert-tab) ; http://stackoverflow.com/questions/69934/set-4-space-indent-in-emacs-in-text-mode
;; (defvaralias 'c-basic-offset 'tab-width)
;;					;(setq ruby-indent-tabs-mode t)
;; (defvaralias 'ruby-indent-level 'tab-width)
;; (defvaralias 'javascript-indent-level 'tab-width)
;;
(require 'key-bindings)
;;
;; ;; Misc
;; (require 'project-archetypes)
;; (require 'my-misc)
;; (when is-mac (require 'mac))
;;
;;
;;
;; ;; Elisp go-to-definition with M-. and back again with M-,
;; (autoload 'elisp-slime-nav-mode "elisp-slime-nav")
;; (add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t) (eldoc-mode 1)))
;;

;; Python yapify
(add-hook 'python-mode-hook 'yapf-mode)

;; ;; Intero setup
;; ;; (add-hook 'haskell-mode-hook 'intero-mode)

;; handy global modes
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'global-auto-complete-mode)
(add-hook 'after-init-hook 'global-undo-tree-mode)
(add-hook 'after-init-hook 'undo-tree-mode)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Conclude init by setting up specifics for the current user
					;(when (file-exists-p user-settings-dir)
					;  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

;; Console sources .bash_profile
(setenv "PATH" (shell-command-to-string "source ~/.bashrc; echo -n $PATH"))

;; menu-set-font
;; (add-to-list 'default-frame-alist '(font . "Andale Mono" ))
;; (set-face-attribute 'default t :font "Andale Mono" )
;; (set-face-attribute 'default nil :height 150)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(zencoding-mode zenburn-theme yaml-mode yafolding whitespace-cleanup-mode vue-mode visual-regexp undo-tree terraform-mode string-edit smartparens simple-httpd rustfmt rust-playground rust-mode rspec-mode rjsx-mode rinari restclient react-snippets psci prodigy perspective paredit nodejs-repl neotree move-text markdown-mode magit-popup magit kotlin-mode jsx-mode json-mode intero ido-vertical-mode ido-at-point htmlize highlight-escape-sequences handlebars-sgml-mode handlebars-mode guide-key groovy-mode gotham-theme golint go-stacktracer go-snippets go-scratch go-rename go-playground go-impl go-guru go-gopath go-errcheck go-eldoc go-dlv go-direx go-autocomplete go-add-tags gist flymake-rust flymake-ruby flymake-cppcheck flycheck-pos-tip flycheck-clojure flx-ido fill-column-indicator exec-path-from-shell elixir-yasnippets elixir-mode elisp-slime-nav edn dockerfile-mode dired-details dash-functional css-eldoc csharp-mode corral company-go clojure-mode-extra-font-locking circe ac-c-headers abyss-theme))))

(require 'setup-company)
