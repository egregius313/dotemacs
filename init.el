;; -*- lexical-binding: t; indent-tabs-mode: nil -*-

;;; Macros organization
(eval-when-compile
  (require 'cl-lib)
  (unless (fboundp 'block)
    (defalias 'block 'cl-block)))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;;; Package management
;;;; straight.el setup
;; I use straight so I can build all my packages from source and not
;; need to worry about package.el
(defvar bootstrap-version)

(eval-and-compile
  (defvar bootstrap-file 
    (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory)
    "File to bootstrap the package manager"))

(eval-when-compile
  (let ((bootstrap-version 5))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
        (goto-char (point-max))
        (eval-print-last-sexp)))))

(load bootstrap-file nil 'nomessage)
(require 'straight)

;;;; use-package
(eval-when-compile
  (straight-use-package 'use-package)
  (require 'use-package))
(eval-and-compile
  (use-package bind-key
    :straight t)
  (setq straight-use-package-by-default t)
  (setq-default use-package-enable-imenu-support t))

(setq vc-follow-symlinks t)

;;; Custom layers
;; I simulate a layer system by simply breaking my configuration up
;; into various files and loading them.
(add-to-list 'load-path (expand-file-name "configuration" user-emacs-directory))

(defmacro load-configuration (configuration-name)
  (let* ((name (symbol-name configuration-name))
         (config-name (concat "config-" name)))
    `(require
      ',(intern config-name)
      ,(expand-file-name config-name (expand-file-name "configuration" user-emacs-directory)))))

(block startup
  (use-package emacs
    :straight nil
    :custom
    (inhibit-startup-message t)
    (ring-bell-function nil)))

;;;; Dashboard
;; Feature a nice dashboard instead of the usual startup message.
(use-package dashboard
  :defer nil
  
  :custom
  (dashboard-items '((recents . 5)
                     (projects . 5)
                     (bookmarks . 5)))
  (dashboard-startup-banner
   (expand-file-name "img/gods_lament.png" user-emacs-directory))
  (dashboard-banner-logo-title "")
  
  :config
  (dashboard-setup-startup-hook)

  (defun emacsos/goto-dashboard ()
    "Goto the buffer which contains the `dashboard'"
    (interactive)
    (switch-to-buffer dashboard-buffer-name))
  
  :bind
  ([XF86HomePage] . emacsos/goto-dashboard))

;;; Appearance
;;;; Themes
(block theme
  (use-package zerodark-theme
    :config
    (load-theme 'zerodark)))

;;;; Superfluous Sidebars
;; Unnecessary side/menu/tool bars get in the way of text. Let's fix
;; that.
(block superfluous-sidebars
  (use-package menu-bar
    :straight nil
    :custom
    (menu-bar-mode nil))

  (use-package tool-bar
    :straight nil
    :custom
    (tool-bar-mode nil))

  (use-package scroll-bar
    :straight nil
    :custom
    (scroll-bar-mode nil)))

;;;; Icons
(block icons
  (use-package all-the-icons
    :defer t)
  (use-package all-the-icons-dired
    :after (all-the-icons dired)))


(load-configuration display/modeline)

;;;; Battery
;; Information about the system's battery
(use-package fancy-battery
  :after doom-modeline
  :commands (fancy-battery-mode)
  :defer t
  :hook
  (doom-modeline . fancy-battery-mode))

(block convenience
  (defalias 'yes-or-no-p 'y-or-n-p))


(load-configuration backups)
(load-configuration keys)

(block project-management
  (use-package projectile
    :config
    (projectile-mode)
    
    :bind
    (:map projectile-mode-map
          ("s-p" . projectile-command-map)
          ("C-c p" . projectile-command-map))))

(load-configuration text)
(load-configuration text/delimiters)
(load-configuration text/indentation)

(use-package compile
  :straight nil
  :bind
  ("s-c" . compile))


(use-package browse-url
  :commands
  (browse-url)
  :custom
  (browse-url-browser-function 'browse-url-generic)
  (browse-url-generic-program "firefox"))


(block bookmarks
  (use-package bookmark
    :straight nil)

  ;; (use-package bookmark-plus
  ;;   :after bookmark
  ;;   :straight t)

  )


(load-configuration org)
(load-configuration org/agenda)
(load-configuration org/brain)


(use-package markdown-mode
  :mode "\\.md\\'"

  :hook
  (markdown-mode . orgtbl-mode))


(ignore-errors
   (load-configuration org/bibliography))

(load-configuration dired)
(load-configuration autocomplete)
(load-configuration lsp)
(load-configuration spelling)
(load-configuration docker)
(load-configuration search)
(load-configuration version-control)
(load-configuration terminal)

(load-configuration lang/emacs-lisp)
(load-configuration lang/go)
(load-configuration lang/python)
(when (executable-find "erl")
  (load-configuration lang/erlang))
(when (and (executable-find "elixir")
           (executable-find "mix"))
  (load-configuration lang/elixir))
(when (and (executable-find "ocaml")
           (executable-find "opam"))
  (load-configuration lang/ocaml))
(load-configuration lang/x86)

(load-configuration cursors)

;; elfeed
(load-configuration rss)

;; Spotify management
(load-configuration applications/spotify)

(load-configuration web)

(use-package flymake
  :straight nil
  :bind
  ("s-e p" . flymake-goto-previous-error)
  ("s-e n" . flymake-goto-next-error))

(use-package helm
  :bind
  ("M-x" . helm-M-x)
  ("C-x r b" . helm-filtered-bookmarks)
  ("C-x C-f" . helm-find-files))

(load-configuration configuration)

(require 'org-capture)

(use-package alloy-mode
  :defer t
  :straight (alloy-mode :type git :host github :repo "egregius313/alloy-mode"))

(use-package windmove
  :bind
  (("s-h" . windmove-left)
   ("s-j" . windmove-down)
   ("s-k" . windmove-up)
   ("s-l" . windmove-right)))


(use-package pdf-tools)

(when (getenv "EXWM")
  (load-configuration window-manager)
  (exwm-init))

(load (expand-file-name ".custom.el" user-emacs-directory) 'noerror)
