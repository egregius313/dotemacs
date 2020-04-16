;;; config-cursors.el --- multiple cursors setup -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))

(use-package phi-search
  :defer 5)

(use-package selected
  :defer 5

  :config
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)

  :bind
  (:map selected-keymap
        ("u" . upcase-region)
        ("l" . downcase-region)))


(use-package multiple-cursors
  :after (phi-search selected)
  :defer 5

  ;; - Sometimes you end up with cursors outside of your view. You can scroll
  ;;   the screen to center on each cursor with `C-v` and `M-v`.
  ;;
  ;; - If you get out of multiple-cursors-mode and yank - it will yank only
  ;;   from the kill-ring of main cursor. To yank from the kill-rings of every
  ;;   cursor use yank-rectangle, normally found at C-x r y.

  :commands (mc/mark-next-like-this mc/mark-prev-like-this)
  
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)

   ("<C-m> ^"     . mc/edit-beginnings-of-lines)
   ("<C-m> `"     . mc/edit-beginnings-of-lines)
   ("<C-m> $"     . mc/edit-ends-of-lines)
   ("<C-m> '"     . mc/edit-ends-of-lines)
   ("<C-m> R"     . mc/reverse-regions)
   ("<C-m> S"     . mc/sort-regions)
   ("<C-m> W"     . mc/mark-all-words-like-this)
   ("<C-m> Y"     . mc/mark-all-symbols-like-this)
   ("<C-m> a"     . mc/mark-all-like-this-dwim)
   ("<C-m> c"     . mc/mark-all-dwim)
   ("<C-m> l"     . mc/insert-letters)
   ("<C-m> n"     . mc/insert-numbers)
   ("<C-m> r"     . mc/mark-all-in-region)
   ("<C-m> s"     . set-rectangular-region-anchor)
   ("<C-m> %"     . mc/mark-all-in-region-regexp)
   ("<C-m> t"     . mc/mark-sgml-tag-pair)
   ("<C-m> w"     . mc/mark-next-like-this-word)
   ("<C-m> x"     . mc/mark-more-like-this-extended)
   ("<C-m> y"     . mc/mark-next-like-this-symbol)
   ("<C-m> C-x"   . reactivate-mark)
   ("<C-m> C-SPC" . mc/mark-pop)
   ("<C-m> ("     . mc/mark-all-symbols-like-this-in-defun)
   ("<C-m> C-("   . mc/mark-all-words-like-this-in-defun)
   ("<C-m> M-("   . mc/mark-all-like-this-in-defun)
   ("<C-m> ["     . mc/vertical-align-with-space)
   ("<C-m> {"     . mc/vertical-align)

   ("S-<down-mouse-1>")
   ("S-<mouse-1>" . mc/add-cursor-on-click))

  :config
  (require 'selected)

  :bind (:map selected-keymap
              ("c"   . mc/edit-lines)
              ("."   . mc/mark-next-like-this)
              ("<"   . mc/unmark-next-like-this)
              ("C->" . mc/skip-to-next-like-this)
              (","   . mc/mark-previous-like-this)
              (">"   . mc/unmark-previous-like-this)
              ("C-<" . mc/skip-to-previous-like-this)
              ("y"   . mc/mark-next-symbol-like-this)
              ("Y"   . mc/mark-previous-symbol-like-this)
              ("w"   . mc/mark-next-word-like-this)
              ("W"   . mc/mark-previous-word-like-this))

  :preface
  (defun reactivate-mark ()
    (interactive)
    (activate-mark)))


(use-package mc-extras
  :after multiple-cursors
  :bind (("<C-m> M-C-f" . mc/mark-next-sexps)
         ("<C-m> M-C-b" . mc/mark-previous-sexps)
         ("<C-m> <"     . mc/mark-all-above)
         ("<C-m> >"     . mc/mark-all-below)
         ("<C-m> C-d"   . mc/remove-current-cursor)
         ("<C-m> C-k"   . mc/remove-cursors-at-eol)
         ("<C-m> M-d"   . mc/remove-duplicated-cursors)
         ("<C-m> |"     . mc/move-to-column)
         ("<C-m> ~"     . mc/compare-chars)))

(provide 'config-cursors)

