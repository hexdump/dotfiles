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

(require 'package)
(let ((proto "http"))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t))
(package-initialize)

(setq package-list '(company multiple-cursors))
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(menu-bar-mode -1)              ;; menubar (file, edit, etc.)
(setq inhibit-startup-screen t) ;; don't open a "welcome to emacs" screen


;;
;; disable autosave of backups cluttering directories
;;

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

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
(setq tab-stop-list (number-sequence 4 200 4))

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
;; don't scroll in pages, scroll in lines
;;
(setq scroll-step            1
      scroll-conservatively  10000)


(setq load-path (cons "~/.emacs.d/lib/" load-path))

(require 'xclip)
(require 'multiple-cursors)
(require 'fill-column-indicator)

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'xclip-mode)


(add-hook 'after-change-major-mode-hook 'fci-mode)
(add-hook 'after-change-major-mode-hook 'xclip-mode)

(global-set-key (kbd "C-M-m l e") 'mc/edit-lines)
(global-set-key (kbd "C-M-m l n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-m l l") 'mc/mark-last-like-this)
(global-set-key (kbd "C-M-m l a") 'mc/mark-all-like-this)

(require 'sticky-resize)

(defun delete-current-line ()
  "Delete (not kill) the current line."
  (interactive)
  (save-excursion
    (delete-region
     (point)
     (progn (forward-visible-line 1) (point)))))

(global-set-key (kbd "C-k") 'delete-current-line)

;;(add-hook 'before-save-hook 'whitespace-cleanup)

;;
;; allow editing of binary .plist files.
;;
(add-to-list 'jka-compr-compression-info-list
             ["\\.plist$"
              "converting text XML to binary plist"
              "plutil"
              ("-convert" "binary1" "-o" "-" "-")
              "converting binary plist to text XML"
              "plutil"
              ("-convert" "xml1" "-o" "-" "-")
              nil nil "bplist"])
(jka-compr-update)

;;
;; enable M-x downcase-region without warning
;;
(put 'downcase-region 'disabled nil)
