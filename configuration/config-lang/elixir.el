;;; config-lang/elixir.el --- Configure Elixir setup -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))

(use-package alchemist
  :defer t
  :when (executable-find "mix"))

(provide 'config-lang/elixir)
