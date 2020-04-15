(eval-when-compile
  (require 'use-package))
(require 'bind-key)

(use-package git)

(defun org-git-version ()
  "The Git version of org-mode.
Inserted by installing org-mode or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
				   "straight/repos/org/" user-emacs-directory)))
	(string-trim
	 (git-run "describe"
			  "--match=release\*"
			  "--abbrev=6"
			  "HEAD"))))

(defun org-release ()
  "The release version of org-mode.
Inserted by installing org-mode or when a release is made."
  (require 'git)
  (let ((git-repo (expand-file-name
				   "straight/repos/org/" user-emacs-directory)))
	(string-trim
	 (string-remove-prefix
	  "release_"
	  (git-run "describe"
			   "--match=release\*"
			   "--abbrev=0"
			   "HEAD")))))

(use-package simple
  :straight nil
  :after org
  
  :hook
  (org-mode . auto-fill-mode))

(use-package org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  
  :custom
  (org-ellipsis " ")
  (org-use-speed-commands t)
  
  :config
  (add-to-list 'org-structure-template-alist
			   '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist
			   '("abs" . "abstract"))

  (add-to-list 'org-speed-commands-user
			   '("T" . org-set-tags-command))

  
  
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((ditaa . t)))

  (require 'org-tempo))


(use-package org-id
  :straight nil

  :bind
  (:map
   org-mode-map
   ("s-i" . org-id-get-create)))

(use-package org-bullets
  :after org
  
  :hook
  (org-mode . org-bullets-mode))


(use-package org-contacts
  :straight nil)


(provide 'config-org)
