;;; -*- lexical-binding: t -*-

(require 'org-archive)

(use-package org-brain
  :after org
  :straight t

  :commands (org-brain-visualize org-brain-goto)

  :custom
  (org-brain-path "~/org/zettelkasten/")
  
  :config
  (add-to-list 'org-contacts-files "~/org/brain/" t)
  (add-to-list 'org-contacts-files "~/org/zettelkasten" t)

  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)

  ;;; TODO: move org-speed-commands for brain to config-org/brain
  (add-to-list 'org-speed-commands-user
			   '("V" . org-brain-visualize))

  (defvar emacsos/org-brain-goto-history nil
	"List of ids for history tracking for jumping back and forth.")
  
  (defun emacsos/org-brain-visit ()
	(interactive)
	(push (cons (org-brain-entry-at-pt) (point)) emacsos/org-brain-goto-history)
	(call-interactively #'org-brain-goto))

  (defun emacsos/org-brain-back ()
	(interactive)
	(when-let* ((e (pop emacsos/org-brain-goto-history))
				(entry (car e))
				(point (cdr e)))
	  (org-brain-goto entry)
	  (goto-char point)))
  
  (defhydra org-brain-speed-commands-hydra (:color blue :hint nil)
	"
^Add^         ^Remove^      ^Goto^                 ^Other^
------------------------------------------------------------------
_p_: parent   _P_: parent   _o_: Goto              _A_: archive
_c_: child    _C_: child    _b_: Go back           _v_: visualize
_f_: friend   _F_: friend   _4_: Goto other window
_h_: headline
_l_: resource
"
	("p" (call-interactively #'org-brain-add-parent))
	("P" (call-interactively #'org-brain-remove-parent))
	("c" (call-interactively #'org-brain-add-child))
	("C" (call-interactively #'org-brain-remove-child))
	("h" (call-interactively #'org-brain-add-child-headline))
	("f" (call-interactively #'org-brain-add-friendship))
	("F" (call-interactively #'org-brain-remove-friendship))
	("A" (call-interactively #'org-brain-archive))
	("l" (call-interactively #'org-brain-add-resource))
	("o" (call-interactively #'emacsos/org-brain-visit))
	("b" (call-interactively #'emacsos/org-brain-back))
	("4" (call-interactively #'org-brain-goto-other-window))
	("v" (call-interactively #'org-brain-visualize))
	("q" nil))
  
  (add-to-list 'org-speed-commands-user
			   '("B" . org-brain-speed-commands-hydra/body))

  :bind
  (("s-b" . org-brain-speed-commands-hydra/body)
   :map org-mode-map
		("s-b" . org-brain-speed-commands-hydra/body)))

(use-package org-brain-export
  :straight (org-brain-export :type git :host github :repo "Kungsgeten/org-brain-export"))

;; (defun emacsos/org-brain-create-person ()
;;   (org-brain-goto )
;;   (org-brain-add-child ))

(defvar emacsos/names-suffixes
  (rx (or "II" "III" "Jr" "Sr" "PhD" "MD" "JD")
	  (opt ".")))

;; (defvar emacsos/names-prefixes)

;; (s-split-words "Edward Minnix III")

;; (defun emacsos/name-key (name)
;;   (let* ((name-parts (s-split-words name))
;; 		 (last-name nil))
;; 	(nreverse name-parts)
;; 	(cl-loop while t
;; 			 for part = (pop name-parts)
			 
;; 			 )
;; 	)
;;   )


(global-set-key (kbd "s-z") (lambda ()
							  (interactive)
							  (org-capture nil "b")))

(provide 'config-org/brain)
