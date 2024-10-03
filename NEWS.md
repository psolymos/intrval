# Version 1.0-0 -- Sep 21, 2024

* Fixing floating point number comparisons (#17).
* Added global package options via `intrval_options()`.
* The `"use_fpCompare"` option controls the use of fpCompare for
  numeric-to-numeric comparisons, default is `TRUE`;
  this is potentially a breaking change, use 
  `intrval_options(use_fpCompare = FALSE)` for the mostly undesirable
  base R behavior.

# Version 0.1-3 -- May 19, 2024

* Maintainer email changed to personal.

# Version 0.1-2 -- August 11, 2020

* Added functions `%[c]%`, `%[c)%`, `%(c]%`, and `%(c)%`
  to divide a range into 3 intervals.
* Added aliases `%nin%` and `%notin%` to `%ni%` for better code readability.

# Version 0.1-1 -- January 21, 2017

* `NA` handling inconsistency fixed and documented (#8).
* All possible interval-to-interval operators added (#6).

# Version 0.1-0 -- December 5, 2016

* CRAN release version.
* Functions finalized.
* Documentation and tests added.

# Version 0.0-1 -- November 26, 2016

* Initial bunch of functions.
