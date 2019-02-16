;;
;; [.emacs.d/init.el]
;;
;; My Emacs configuration file.
;; Copyright (C) Liam Schumm, 2018.
;; Licensed under the terms of the GNU GPL v3.0 License.
;;


;;
;; remove all useless graphical cruft
;;

(menu-bar-mode -1)              ;; menubar (file, edit, etc.)
(setq inhibit-startup-screen t) ;; don't open a "welcome to emacs" screen


;;
;; disable autosave of backups cluttering directories
;;

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;
;; initialize packages
;;

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


;;
;; make custom not write to init.el, but a seperate file
;;

(setq custom-file "~/.emacs.d/custom.el") ;; set custom file
(load custom-file 'noerror)               ;; load custom file (required)


;;
;; macros
;;

;; copyright insert
(defun copyright (comment)
  (interactive "sComment Character: ")
  (insert comment)
  (insert "\n")
  (insert comment)
  (insert " [")
  (insert (read-string "Title: "))
  (insert "]\n")
  (insert comment)
  (insert "\n")
  (insert comment)
  (insert " ")
  (insert (read-string "Description: "))
  (insert "\n")
  (insert comment)
  (insert " Copyright (C) 2019, Liam Schumm")
  (insert "\n")
  (insert comment)
  (insert "\n"))

;; hashbang insert
(defun hashbang (command)
  (interactive "sCommand: ")
  (insert "#!/usr/bin/env ")
  (insert command)
  (insert "\n"))

;; hashbang and copyright insert
(defun hashcopy ()
  (interactive)
  (call-interactively 'hashbang)
  (call-interactively 'copyright))


;;
;; use spaces instead of tabs
;;

(setq-default indent-tabs-mode nil)


;;
;; when started up, open an empty scratch buffer
;;

(setq initial-scratch-message "")
;; for some reason, you need to provide your username to
;; 'inhibit-startup-echo-area-message. i have no clue why.
(setq inhibit-startup-echo-area-message "lschumm")
(setq inhibit-startup-message t)
(message nil)
(setq initial-major-mode 'text-mode)


;;
;; hide mode line by setting it to header format (header is hidden)
;;

(setq header-line-format mode-line-format)
(setq-default mode-line-format nil)
(setq-default header-line-format mode-line-format)


;;
;; enable wakatime
;;

(global-wakatime-mode)
(custom-set-variables '(wakatime-api-key "92dd49d1-4090-40ef-beb9-e7129c6f252b"))
