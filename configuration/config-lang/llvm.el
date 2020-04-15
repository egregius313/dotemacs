;;;  -*- lexical-binding: t -*-

(add-to-list 'load-path "~/gitdownloads/llvm/utils/emacs/")

(use-package llvm-mode
  :straight nil)

(use-package tablegen-mode
  :straight nil)

(provide 'config-lang/llvm)
