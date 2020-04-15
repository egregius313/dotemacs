;;; config-org/babel.el -*- lexical-binding: t -*-
(require 'org)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (lisp . t)))

(provide 'config-org/babel)
