;;; config-icons.el -*- lexical-binding: t -*-
(eval-when-compile
  (require 'use-package))
(eval-and-compile
  (require 'bind-key))

(defconst emacsos/agenda-icon-alist
  '((faicon . all-the-icons-faicon)
	(material . all-the-icons-material)
	(octicon . all-the-icons-octicon)
	(fileicon . all-the-icons-fileicon)
	(alltheicon . all-the-icons-alltheicon)))

(defun define-agenda-icon (category icon-set icon-name &optional regex)
  (let* ((icon-function (alist-get icon-set emacsos/agenda-icon-alist))
		 (icon (funcall icon-function icon-name))
		 (category-selector (if regex
								category
							  (concat (rx bos) category (rx eos))))
		 (entry (list category-selector (list icon) nil nil :ascent 'center)))
	(add-to-list 'org-agenda-category-icon-alist entry)))

(define-agenda-icon "Compilers" 'faicon "cogs")

(dolist (legend '("Reading List" "Read -- Hackers" "Read -- Viking" "Read -- CATB"))
  (define-agenda-icon legend 'faicon "book"))

(define-agenda-icon "Bible" 'octicon "book")
(define-agenda-icon "Listen -- Skyward" 'material "audiotrack")
(define-agenda-icon "Language" 'faicon "language")
(define-agenda-icon "Emacs" 'fileicon "emacs")
(define-agenda-icon "Computer" 'material "computer")
(define-agenda-icon "Security" 'material "security")
(define-agenda-icon "HomeAssistant" 'material "assistant")
(define-agenda-icon "Podcast" 'octicon "radio-tower")
(define-agenda-icon "Email" 'material "mail")
(define-agenda-icon "Send Email" 'material "mail")
(define-agenda-icon "Send Mail" 'material "mail")
(define-agenda-icon "Mail" 'material "mail")
(define-agenda-icon "Work" 'material "work")
(define-agenda-icon "Unisys" 'material "work")
(define-agenda-icon "unisys" 'material "work")
(define-agenda-icon "TA" 'material "work")
(define-agenda-icon "CPR" 'octicon "rocket")
(define-agenda-icon "Rocket" 'octicon "rocket")
(define-agenda-icon "Rocketry" 'octicon "rocket")
(define-agenda-icon "Food" 'faicon "apple")
(define-agenda-icon "Birthday" 'faicon "birthday-cake")
(define-agenda-icon "workouts" 'material "fitness_center")

(define-agenda-icon "Firefox" 'faicon "firefox")

(define-agenda-icon "C" 'alltheicon "c-line")
(define-agenda-icon "Go" 'fileicon "go")
(define-agenda-icon "Haskell" 'alltheicon "haskell")
(define-agenda-icon "Java" 'alltheicon "java")
(define-agenda-icon "Kotlin" 'fileicon "kotlin")
(define-agenda-icon "Prolog" 'alltheicon "prolog")
(define-agenda-icon "Clojure" 'alltheicon "clojure")
(define-agenda-icon "Erlang" 'alltheicon "erlang")
(define-agenda-icon "Elixir" 'alltheicon "elixir")
(define-agenda-icon "Scala" 'alltheicon "scala")
(define-agenda-icon "Lisp" 'fileicon "lisp")
(define-agenda-icon "Python" 'alltheicon "python")
(define-agenda-icon "Rust" 'alltheicon "rust")
(define-agenda-icon "Coq" 'fileicon "coq")


(provide 'config-icons)
