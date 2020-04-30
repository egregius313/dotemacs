;;; config-web.el --- Configure Emacs for web development -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package simple-httpd)

(use-package impatient-mode
  :after simple-httpd

  :custom
  (impatient-mode-delay 0.5))

(use-package emmet-mode
  :hook
  (html-mode . emmet-mode))

(use-package tagedit
  :bind
  (:map tagedit-mode-map
		("C-<left>" . tagedit-forward-barf-tag)
		("C-<right>" . tagedit-forward-slurp-tag))
  
  :hook
  (html-mode . tagedit-mode))

(provide 'config-web)
