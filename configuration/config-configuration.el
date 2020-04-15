;;; config-configuration.el -*- lexical-binding: t -*-

(eval-when-compile
  (require 'dash))
(require 'f)
(require 'helm)

(defcustom configuration-configs-directory
  (expand-file-name "configuration" user-emacs-directory)
  "The directory where custom configuration layers are stored.")

(defun configure-get-configurations ()
  (cl-loop for configuration in (directory-files-recursively configuration-configs-directory "\\.el\\'" nil)
		   collect (replace-regexp-in-string (rx (* anything) "config-" (group (+ (or alnum ?/ ?-))) ".el") "\\1" configuration)))


(defun configure (configuration)
  (interactive 
   (list
    (helm-comp-read
     "Configuration: "
     (configure-get-configurations)
     :name "Configuration Layers")))
  (let ((configuration-file (-> (concat "config-" configuration)
                                (expand-file-name configuration-configs-directory)
                                (concat ".el"))))
    (find-file configuration-file)))


(defun configuration-configuration-p (filename)
  "Determine whether or not `filename' is a child of the configuration directory."
  (f-ancestor-of-p
   configuration-configs-directory
   filename))

(defun configuration-name (&optional buffer)
  (let* ((f (buffer-file-name buffer))
		 (d (-> f file-name-directory directory-file-name file-name-nondirectory))
		 (b (string-remove-suffix ".el" (file-name-nondirectory (buffer-file-name buffer)))))
	(if (string-prefix-p "config-" b)
		b
	  (concat d "/" b))))

(unless (key-binding (kbd "C-c s-c"))
  (global-set-key (kbd "C-c s-c") 'configure))
(unless (key-binding (kbd "C-c C-c"))
  (global-set-key (kbd "C-c C-c") 'configure))

(when (fboundp 'key-chord-define)
  (key-chord-define-global (kbd "s-c s-c") 'configure))


(defun configuration-build-configurations ()
  (interactive)
  (cl-loop for configuration in (directory-files-recursively configuration-configs-directory "\\.el\\'" nil)
		   when (file-newer-than-file-p configuration (concat configuration "c"))
		   do (byte-compile-file configuration)))


(provide 'config-configuration)
