;;; config-text.el -*- lexical-binding: t -*-

(use-package unfill
  :commands (unfill-paragraph unfill-toggle)
  :bind
  ([remap fill-paragraph] . unfill-toggle))

(use-package evil-nerd-commenter
  :defer t
  :commands (evilnc-comment-or-uncomment-paragraphs)
  :chords
  ((";p" . evilnc-comment-or-uncomment-paragraphs)))

(use-package anzu
  :diminish anzu-mode
  :defer t
  
  :custom
  (anzu-cons-mode-line-p nil)
  
  :bind
  (([remap query-replace] . anzu-query-replace)
   ([remap query-replace-regexp] . anzu-query-replace-regexp))
  
  :config
  (global-anzu-mode 1))

  
(use-package subword-mode
  :straight nil
  :hook
  ((java-mode csharp-mode haskell-mode) . subword-mode))

(use-package expand-region
  :config
  (defhydra expand-region-hydra ()
    "Expand region"
    ("w" er/mark-word)
    ("s" er/mark-symbol)
    ("p" er/mark-symbol-with-prefix)
    ("a" er/mark-next-accessor)
    ("m" er/mark-method-call)
    ("'" er/mark-inside-quotes)
    ("\"" er/mark-outside-quotes)
    ("(" er/mark-inside-pairs)
    (")" er/mark-outside-pairs)
    (";" er/mark-comment)
    ("u" er/mark-url)
    ("e" er/mark-email)
    ("d" er/mark-defun))
  :bind
  ("s-q" . expand-region-hydra/body))

(provide 'config-text)
