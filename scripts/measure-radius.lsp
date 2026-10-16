;; measure-radius.lsp - Radius, diameter and circumference for circles and arcs
;; Command: MRAD
(defun c:MRAD ( / ss i en ed typ rad )
  (setq ss (ssget '((0 . "CIRCLE,ARC"))))
  (if ss
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i) ed (entget en) typ (cdr (assoc 0 ed)))
        (setq rad (cdr (assoc 40 ed)))
        (princ (strcat "\n" typ ": R=" (rtos rad 2 4)
                       "  D=" (rtos (* 2.0 rad) 2 4)
                       "  C=" (rtos (* 2.0 pi rad) 2 4)))
        (setq i (1+ i))
      )
    )
    (princ "\nNothing selected.")
  )
  (princ)
)
