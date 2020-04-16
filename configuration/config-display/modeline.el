;;; modeline.el -- Format modeline -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))


;; Used by use-package for the :diminish keyword to work. Helps remove
;; minor modes from the modeline when unnecessary.
(use-package diminish)

(use-package doom-modeline
  :commands (doom-modeline-mode)

  :custom
  (doom-modeline-buffer-file-name-style 'buffer-name)
  (doom-modeline-major-mode-color-icon t)

  :hook
  (after-init . doom-modeline-mode))

;;;; Time
(use-package time
  :custom
  (display-time-24hr-format t)
  (display-time-format "%H:%M - %B %d %Y")
  (display-time-mode t))

;;;; Line and column numbers
(use-package simple
  :straight nil
  :custom
  (line-number-mode t)
  (column-number-mode t))

(use-package nyan-mode
  :commands (nyan-mode)

  :custom
  (nyan-animate-nyancat t)
  (nyan-wavy-trail nil))

(nyan-mode)

(provide 'config-display/modeline)
