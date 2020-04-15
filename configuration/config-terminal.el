;;; -*- lexical-binding: t -*-

(add-to-list 'load-path (expand-file-name "modules/emacs-libvterm" user-emacs-directory))

(use-package vterm
  :when (file-directory-p (expand-file-name "modules/emacs-libvterm" user-emacs-directory))
  :straight nil
  :bind
  ("s-v" . vterm)

  :custom
  (vterm-kill-buffer-on-exit t)
  
  :config
  (add-to-list 'vterm-eval-cmds '("man" man)))

(provide 'config-terminal)
