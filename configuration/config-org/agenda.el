(eval-when-compile
  (require 'use-package))
(require 'all-the-icons)

(use-package org-agenda
  :after org
  :straight nil
  :commands (org-agenda)

  :custom
  (org-agenda-show-all-dates t)
  (org-agenda-skip-scheduled-if-done nil)
  (org-agenda-span 'week)
  (org-agenda-start-on-weekday 0)
  
  :init
  (add-to-list 'org-agenda-files "~/org/agendas")
  (add-to-list 'org-agenda-files "~/org/brain/reading-list.org")
  (add-to-list 'org-agenda-files "~/.notes"))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
	(org-todo (if (zerop n-not-done) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


(provide 'config-org/agenda)
