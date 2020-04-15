;;; config-text/indentation.el -*- lexical-binding: t -*-

(setq-default tab-width 4)

(defun indent-buffer ()
  "Indent current buffer according to major mode"
  (interactive)
  (indent-region (point-min) (point-max)))

(use-package indent
  :straight nil
  :bind
  ("C-c <tab>" . indent-buffer))


(provide 'config-text/indentation)
