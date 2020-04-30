;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))
(require 'config-lsp)

(use-package rust-mode
  :hook
  (rust-mode . lsp))

(use-package smartparens
  :config
  (sp-local-pair 'rust-mode "'" nil :actions nil)

  :hook
  (rust-mode . smart-parens-mode))

(use-package cargo)

(provide 'config-lang/rust)
