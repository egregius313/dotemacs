;;; config-lang/elixir.el --- Configure Elixir setup -*- lexical-binding: t -*-

(use-package alchemist
  :defer t
  :when (executable-find "mix"))

(provide 'config-lang/elixir)
