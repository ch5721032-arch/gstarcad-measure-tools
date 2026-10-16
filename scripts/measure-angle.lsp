;; measure-angle.lsp - Angle between three picked points
;; Command: MANG
(defun c:MANG ( / p1 p2 p3 a1 a2 ang )
  (setq p1 (getpoint "\nFirst point: "))
  (setq p2 (getpoint p1 "\nVertex point: "))
  (setq p3 (getpoint p2 "\nThird point: "))
  (if (and p1 p2 p3)
    (progn
      (setq a1 (angle p2 p1) a2 (angle p2 p3))
      (setq ang (abs (- a2 a1)))
      (if (> ang pi) (setq ang (- (* 2.0 pi) ang)))
      (princ (strcat "\nAngle: " (rtos (* ang (/ 180.0 pi)) 2 4) " degrees"))
    )
  )
  (princ)
)
