;;; config-web.el --- Configure Emacs for web development -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))

(use-package simple-httpd)

(use-package impatient-mode
  :after simple-httpd)

(use-package emmet-mode
  :hook
  (html-mode . emmet-mode))

(use-package tagedit
  :hook
  (html-mode . tagedit-mode))

(provide 'config-web)
