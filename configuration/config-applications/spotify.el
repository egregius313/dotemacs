;;; config-application/spotify.el -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))


(require 'hydra)

(use-package spot4e
  :straight (spot4e :type git :host github :repo "chiply/spot4e")

  :custom
  (spot4e-refresh-token "AQDXfpsnL4AyG_mzwM2MURWk2Tpyk4IKFhughv7tBZ1bNg2NzOrlOJYxOLeVjtEnB9IT0W_SRvCknuznGmaTcsG4R-stjZk7UYWGyXt4F07FdJTZqvF0phCVzwOzCgWptok")

  :bind
  ([s-f9] . spot4e-hydra/body)
  
  :config
  (run-with-timer 0 (* 60 59) 'spot4e-refresh)

  (defhydra spot4e-hydra ()
	("a" (call-interactively #'spot4e-helm-search-albums) :color blue)
	("A" (call-interactively #'spot4e-helm-search-artists) :color blue)
	("t" (call-interactively #'spot4e-helm-search-tracks) :color blue)
	("p" (spot4e-player-previous))
	("n" (spot4e-player-next))
	("SPC" (spot4e-player-toggle))))


(defun spot4e-player-toggle ()
  (interactive)
  (let ((context (spot4e-get-currently-playing-context)))
	(if (alist-get 'is_playing context)
		(spot4e-player-pause)
	  (spot4e-player-play))))

(provide 'config-applications/spotify)
