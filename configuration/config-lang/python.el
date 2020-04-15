;;; config-lang/python.el -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))

(use-package lsp-python-ms
  :after lsp
  :custom
  (lsp-python-ms-executable
   (expand-file-name "lang-servers/python-language-server/output/bin/Release/linux-x64/publish/Microsoft.Python.LanguageServer"
                     user-emacs-directory))
  (lsp-python-ms-python-executable-cmd "python3")

  :hook
  (python-mode . (lambda ()
                   (require 'lsp-python-ms)
                   (lsp))))

(provide 'config-lang/python)
