;;; config-search.el --- Configure searching in buffers and directories -*- lexical-binding: t -*-

(use-package rg
  :when (executable-find "rg")

  :bind
  (:map projectile-command-map
		("C-s" . rg-project)))

(use-package deadgrep
  :when (executable-find "rg"))

(provide 'config-search)
