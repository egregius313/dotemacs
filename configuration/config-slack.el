;;; -*- lexical-binding: t -*-

(use-package slack
  :commands (slack-start)
  :custom
  (slack-prefer-current-team t)

  :config
  (slack-register-team
   :name "sittv"
   :default t
   :token "xoxs-11396380576-235943641520-816539899766-5af98abe07cb66e67c84bd4e8db4c547a45de9b45b762bb433309b26c3ade1b5"
   :subscribed-channels '()
   :full-and-display-names t))


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
