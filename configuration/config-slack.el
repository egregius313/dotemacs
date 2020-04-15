;;; -*- lexical-binding: t -*-

(use-package slack
  :commands (slack-start)
  :custom
  (slack-prefer-current-team t))


(use-package all-the-icons
  :config
  (add-to-list 'all-the-icons-mode-icon-alist
			   '(slack-message-buffer-mode
				 all-the-icons-faicon "slack"
				 :v-adjust 0.0 :face all-the-icons-purple))
  (add-to-list 'all-the-icons-mode-icon-alist
			   '(slack-thread-message-buffer-mode
				 all-the-icons-faicon "slack"
				 :v-adjust 0.0 :face all-the-icons-purple)))


(provide 'config-slack)
