# GstarCAD Measure Tools

Keep a running distance total, read radius, diameter and circumference at once, and measure the angle between three points.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Measuring in CAD is usually a chain of single-purpose commands. These helpers keep a running total while you measure point to point, print radius, diameter and circumference for every circle and arc you select, and give you the true angle between three picked points without any mental arithmetic.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/quick-dist.lsp` | ;; quick-dist.lsp - Keep measuring and accumulate the total distance
;; Command: QDIST
(defun c:QDIST ( / p1 p2 d total n )
  (setq total 0.0 n 0)
  (setq p1 (getpoint "\nFirst point: "))
  (while (and p1 (setq p2 (getpoint p1 "\nNext point (Enter to stop): ")))
    (setq d (distance p1 p2))
    (setq total (+ total d))
    (setq n (1+ n))
    (princ (strcat "\nSegment: " (rtos d 2 4) "   Running total: " (rtos total 2 4)))
    (setq p1 p2)
  )
  (if (> n 0)
    (princ (strcat "\nSegments: " (itoa n) "  Total distance: " (rtos total 2 4)))
  )
  (princ)
)
 |
| `scripts/measure-radius.lsp` | ;; measure-radius.lsp - Radius, diameter and circumference for circles and arcs
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
 |
| `scripts/measure-angle.lsp` | ;; measure-angle.lsp - Angle between three picked points
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
