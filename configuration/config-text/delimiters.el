;;; config-text/delimiters.el -*- lexical-binding: t -*-

(use-package paren
  :straight nil
  :custom
  (show-paren-delay 0)
  (show-paren-mode t))

(use-package rainbow-delimiters
  :defer t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package paredit
  :diminish paredit-mode

  :hook
  ((emacs-lisp-mode) . paredit-mode))

(provide 'config-text/delimiters)
