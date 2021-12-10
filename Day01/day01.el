;;; day01 --- Day 1 in Advent of Code 2021

;; Copyright (C) 2021 Free Software Foundation, Inc.

;; Author: semenInRussia <hrams205@gmail.com>
;; Version: 0.0.1
;; Packages-Requires: ((dash "2.18.0")
                      ;(s     "1.12.0"))
                      ;(f     "0.20.0"))
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(require 's)
(require 'dash)
(require 'f)

(defvar content (f-read-text "input.txt"))

(defun part1 ()
    "Part 1 of Task."
    (let* ((lines (s-lines content))
           (nums (-map 'string-to-number lines)))
        (num-of-greater-right-neighbors nums))
    )


(defun part2 ()
    "Part 2 of first day of Advent of Code 2021."
    (let* ((lines (s-lines content))
           (nums (-map 'string-to-number lines))
           (sums (-map '-sum (-partition-in-steps 3 1 nums))))
        (num-of-greater-right-neighbors sums))
    )


(defun num-of-greater-right-neighbors (numbers)
    "Get number of cases when left num greater than right num from `NUMBERS`."
    (--count (< (-first-item it) (-second-item it))
             (-partition-in-steps 2 1 numbers))
    )


(part2)

(provide 'day01)
;;; day01.el ends here
