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
(tool-bar-mode -1)              ;; big ugly tooltips
(toggle-scroll-bar -1)          ;; graphical scrollbar
(set-fringe-mode -1)            ;; "fringe" borders on sides of window
(setq inhibit-startup-screen t) ;; don't open a "welcome to emacs" screen

;;
;; don't write backups in the same directory as the file
;;

(setq backup-directory-alist `(("." . "~/.saves")))

;;
;; theming
;;

(load-theme 'dichromacy) ;; default theme
(set-face-attribute 'default nil
		    :family "Meslo"
                    :height 90
                    :weight 'normal
                    :width 'normal)

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
;; copyright inserting macro
;;

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
  (insert " Copyright (C) 2018, Liam Schumm")
  (insert "\n")
  (insert comment)
  (insert "\n"))
