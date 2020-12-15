;;
;; [.emacs.d/init.el]
;;
;; My Emacs configuration file.
;; Copyright (C) Liam Schumm, 2018-2020.
;; Licensed under the terms of the GNU GPL v3.0 License.
;;

;;
;; make custom not write to init.el, but a separate file.
;;
(setq custom-file "~/.emacs.d/custom.el") ;; set custom file.
(load custom-file 'noerror)               ;; load custom file (required).

;;
;; remove graphical stuff that i don't use.
;;
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;;
;; enable packages.
;;
(require 'package)
(let ((proto "http"))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")) t))
(package-initialize)

;;
;; ensure we have all of these packages; if not,
;; install them.
;;
(setq package-list '(company multiple-cursors xclip))
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;
;; disable autosave of backups cluttering directories.
;;
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq create-lockfiles nil)

;;
;; use spaces instead of tabs.
;;
(setq-default indent-tabs-mode nil)

;;
;; don't include a description in the scratch buffer.
;;
(setq initial-scratch-message "")

;;
;; don't scroll in pages, scroll in lines.
;;
(setq scroll-step            1
      scroll-conservatively  10000)

(setq load-path (cons "~/.emacs.d/lib/" load-path))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 

(require 'xclip)
(require 'multiple-cursors)

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'xclip-mode)

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

;;
;; truncate lines instead of wrapping
;;
(set-default 'truncate-lines t)

(add-hook 'verilog-mode-hook (lambda () (setq verilog-auto-endcomments nil)))
(toggle-scroll-bar -1)
(add-hook 'after-make-frame-functions (lambda (frame) (toggle-scroll-bar -1)))

(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))

;; Custom mode line setup, special thanks to Amit Patel
;; http://amitp.blogspot.com/2011/08/emacs-custom-mode-line.html
(setq-default mode-line-format
      (list
       "  "
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize "%b @ %l %c"))

    ))

(add-to-list 'default-frame-alist '(font . "mononoki-12"))
(setq-default mode-line-format nil)

;; from https://www.emacswiki.org/emacs/HeaderLine
(defun with-face (str &rest face-plist)
  (propertize str 'face face-plist))


(defun sl/make-header ()
  ""
  (let* ((sl/full-header (abbreviate-file-name buffer-file-name))
         (sl/header (file-name-directory sl/full-header))
         (sl/drop-str "[...]"))
    (if (> (length sl/full-header)
           (window-body-width))
        (if (> (length sl/header)
               (window-body-width))
            (progn
              (concat (with-face sl/drop-str
                                 :weight 'bold
                                 )
                      (with-face (substring sl/header
                                            (+ (- (length sl/header)
                                                  (window-body-width))
                                               (length sl/drop-str))
                                            (length sl/header))
                                 ;; :background "red"
                                 :weight 'bold
                                 )))
          (concat (with-face sl/header
                             ;; :background "red"
                             :foreground "#8fb28f"
                             :weight 'bold
                             )))
      (concat (with-face sl/header
                         ;; :background "green"
                         ;; :foreground "black"
                         :weight 'bold
                         :foreground "#DB9D47"
                         )
              (with-face (file-name-nondirectory buffer-file-name)
                         :weight 'bold
                         ;; :background "red"
                         )))))

(defun sl/display-header ()
  (setq header-line-format
        '("" ;; invocation-name
          (:eval (if (buffer-file-name)
                     (sl/make-header)
                   "%b"))
          " | %l,%c ")))

(add-hook 'buffer-list-update-hook
          'sl/display-header)

(load-theme 'plants)
(require 'templates)

(defun er-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))
(global-set-key (kbd "C-c b") #'er-switch-to-previous-buffer)


; Don't show dot files in the completion...                               
(require 'cl-lib) ; Needed for cl-remove-if-not                                        

; Define string-suffix-p.                                                       
(defun string-suffix-p (str1 str2 &optional ignore-case)
  (let ((begin2 (- (length str2) (length str1))) (end2 (length str2)))
    (when (< begin2 0) (setq begin2 0))
    (eq t (compare-strings str1 nil nil str2 begin2 end2 ignore-case))))

; Modify to return true for files you're interested in.                         
(defun my-file-match (str)
  (and (not (cl-remove-if-not (lambda (x) (string-suffix-p x str))
                               completion-ignored-extensions))
       (not (string-prefix-p "." str))))

; Add the advice after completion.                                              
(defadvice completion-file-name-table (after ignoring-backups-f-n-completion
                                             activate)
  (if (and (listp ad-return-value) (stringp (car ad-return-value))
           (cdr ad-return-value))
      (let ((newlis (cl-remove-if-not 'my-file-match ad-return-value)))
        ; If there are no qualifiers, list everything.                          
        (if (and (listp newlis) (cdr newlis))
            (setq ad-return-value newlis)))))
