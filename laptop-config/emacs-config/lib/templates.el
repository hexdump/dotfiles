;;
;; [.emacs.d/macros.el]
;;
;; A couple code templates that I've made into Emacs commands
;; so I can easily use them.
;; Copyright (C) Liam Schumm, 2020.
;; Licensed under the terms of the GNU GPL v3.0 License.
;;

;; copyright insert.
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
  (insert " Copyright (C) 2020, Leslie Schumm")
  (insert "\n")
  (insert comment)
  (insert "\n"))

;; hashbang insert.
(defun hashbang (command)
  (interactive "sCommand: ")
  (insert "#!/usr/bin/env ")
  (insert command)
  (insert "\n"))

;; hashbang and copyright insert.
(defun hashcopy ()
  (interactive)
  (call-interactively 'hashbang)
  (call-interactively 'copyright))

(provide 'templates)
