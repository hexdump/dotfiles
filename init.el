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
(set-fringe-mode 0)            ;; "fringe" borders on sides of window
(setq inhibit-startup-screen t) ;; don't open a "welcome to emacs" screen


;;
;; disable autosave of backups cluttering directories
;;

(setq backup-inhibited t)
(setq auto-save-default nil)


;;
;; theming
;;

(load-theme 'dichromacy) ;; default theme


;;
;; fonts
;;

;; load Vulf Mono Italic as the default theme
(set-face-attribute 'default nil
		    :family "Vulf Mono"
                    :height 90
                    :slant 'italic
                    :weight 'normal
                    :width 'normal)

;; make comments bold
(set-face-attribute 'font-lock-comment-face nil
                    :weight 'bold)
(set-face-attribute 'font-lock-comment-delimiter-face nil
                    :weight 'bold)


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
  (insert " Copyright (C) 2018, Liam Schumm")
  (insert "\n")
  (insert comment)
  (insert "\n"))


;;
;; use spaces instead of tabs
;;

(setq-default indent-tabs-mode nil)


;;
;; when started up, open an empty scratch buffer
;;

(setq initial-scratch-message "")
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
