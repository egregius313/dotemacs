;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package page-break-lines
  :hook
  (emacs-lisp-mode . page-break-lines-mode))

(use-package macrostep
  :commands (macrostep-expand macrostep-mode)
  :bind
  (:map emacs-lisp-mode-map
		("s-m" . macrostep-mode)))

(provide 'config-lang/emacs-lisp)
