;;; -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))

(use-package tuareg
  :mode ("\\.ocamlinit\\'")

  :hook
  ((tuareg-mode . paredit-mode)))


(use-package merlin
  :after (:any tuareg caml)

  :config
  (progn
	(add-to-list 'company-backends 'merlin-company-backend)

	(use-package flycheck-ocaml
	  :after (flycheck)

	  :config
	  (progn
		(setq merlin-error-after-save nil)
		(flycheck-ocaml-setup))))

  :hook
  ((merlin-mode . company-mode)
   ((tuareg-mode caml-mode) . merlin-mode))

  :bind
  (:map merlin-mode-map
		([remap xref-find-definitions] . merlin-locate)
		([remap xref-pop-marker-stack] . merlin-pop-stack)))


(use-package merlin-eldoc
  :after (merlin)
  :config
  (merlin-eldoc-setup))


(use-package utop
  :config
  (setq utop-command "opam config exec -- utop -emacs")

  :hook
  ((tuareg-mode . utop-minor-mode)
   (utop-minor-mode . company-mode)))


;; (let* ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share"))))
;; 	   (opam-site-lisp (expand-file-name "emacs/site-lisp" opam-share)))
;;   (add-to-list 'load-path opam-site-lisp)
;;   (use-package gopcaml-mode
;; 	:straight nil
;; 	:when (and opam-share (file-directory-p opam-share))
;; 	:hook
;; 	(tuareg-mode . gopcaml-mode)))


(provide 'config-lang/ocaml)
