

(defun sticky-enlarge-window-horizontally (prefix)
  (interactive "P")
  (enlarge-window-horizontally (if prefix (car prefix) 1))
  (unless (current-message)
    (message "(Now hold `{' or `}' to adjust window size)"))
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "{") 'shrink-window-horizontally)
    (define-key map (kbd "}") 'enlarge-window-horizontally)
    (set-transient-map map t)))

(defun sticky-shrink-window-horizontally (prefix)
  (interactive "P")
  (shrink-window-horizontally (if prefix (car prefix) 1))
  (unless (current-message)
    (message "(Now hold `{' or `}' to adjust window size)"))
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "{") 'shrink-window-horizontally)
    (define-key map (kbd "}") 'enlarge-window-horizontally)
    (set-transient-map map t)))

(define-key global-map (kbd "C-^") 'enlarge-window)
(define-key global-map (kbd "C-x }") 'sticky-enlarge-window-horizontally)
(define-key global-map (kbd "C-x {") 'sticky-shrink-window-horizontally)

(provide 'sticky-resize)
