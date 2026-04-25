# Relational Operators Comparing Two Intervals

Functions for evaluating if two intervals overlap or not.

## Usage

``` r
interval1 %[o]% interval2
interval1 %)o(% interval2
interval1 %[<o]% interval2
interval1 %[o>]% interval2

interval1 %(o)% interval2
interval1 %]o[% interval2
interval1 %(<o)% interval2
interval1 %(o>)% interval2

interval1 %[]o[]% interval2
interval1 %[]o[)% interval2
interval1 %[]o(]% interval2
interval1 %[]o()% interval2
interval1 %[)o[]% interval2
interval1 %[)o[)% interval2
interval1 %[)o(]% interval2
interval1 %[)o()% interval2
interval1 %(]o[]% interval2
interval1 %(]o[)% interval2
interval1 %(]o(]% interval2
interval1 %(]o()% interval2
interval1 %()o[]% interval2
interval1 %()o[)% interval2
interval1 %()o(]% interval2
interval1 %()o()% interval2
```

## Arguments

- interval1, interval2:

  vector, 2-column matrix, list, or `NULL`: the interval end points of
  two (sets) of closed intervals to compare.

## Details

The operators define the open/closed nature of the lower/upper limits of
the intervals on the left and right hand side of the `o` in the middle.

The overlap of two closed intervals, \[a1, b1\] and \[a2, b2\], is
evaluated by the `%[o]%` (alias for `%[]o[]%`) operator (a1 \<= b1, a2
\<= b2). Endpoints can be defined as a vector with two values
(`c(a1, b1)`)or can be stored in matrix-like objects or a lists in which
case comparisons are made element-wise. If lengths do not match, shorter
objects are recycled. These value-to-interval operators work for numeric
(integer, real) and ordered vectors, and object types which are measured
at least on ordinal scale (e.g. dates), see Examples. Note: interval
endpoints are sorted internally thus ensuring the conditions a1 \<= b1
and a2 \<= b2 is not necessary. `%)o(%` is used for the negation of two
closed interval overlap, directional evaluation is done via the
operators `%[<o]%` and `%[o>]%`.

The overlap of two open intervals is evaluated by the `%(o)%` (alias for
`%()o()%`). `%]o[%` is used for the negation of two open interval
overlap, directional evaluation is done via the operators `%(<o)%` and
`%(o>)%`.

Overlap operators with mixed endpoint do not have negation and
directional counterparts.

## Value

A logical vector, indicating if `interval1` overlaps `interval2`. Values
are `TRUE`, `FALSE`, or `NA`.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

See help page for relational operators:
[`Comparison`](https://rdrr.io/r/base/Comparison.html).

See [`%[]%`](intrval.md) for relational operators for value-to-interval
comparisons.

See [`factor`](https://rdrr.io/r/base/factor.html) for the behavior with
factor arguments. See also [`%in%`](https://rdrr.io/r/base/match.html)
for value matching and [`%ni%`](ni.md) for negated value matching for
factors.

See [`Syntax`](https://rdrr.io/r/base/Syntax.html) for operator
precedence.

## Examples

``` r
## motivating examples from example(lm)

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept
## compare 95% confidence of the 2 groups to each other
(CI.D90 <- confint(lm.D90))
#>            2.5 %  97.5 %
#> groupCtl 4.56934 5.49466
#> groupTrt 4.19834 5.12366
CI.D90[1,] %[o]% CI.D90[2,]
#> 2.5 % 
#>  TRUE 

## simple interval comparisons
c(2:3) %[o]% c(0:1)
#> [1] FALSE

## vectorized comparisons
c(2:3) %[o]% list(0:4, 1:5)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE
c(2:3) %[o]% cbind(0:4, 1:5)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE
c(2:3) %[o]% data.frame(a=0:4, b=1:5)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE
list(0:4, 1:5) %[o]% c(2:3)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE
cbind(0:4, 1:5) %[o]% c(2:3)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE
data.frame(a=0:4, b=1:5) %[o]% c(2:3)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE

list(0:4, 1:5) %[o]% cbind(rep(2,5), rep(3,5))
#> [1] FALSE  TRUE  TRUE  TRUE FALSE
cbind(rep(2,5), rep(3,5)) %[o]% list(0:4, 1:5)
#> [1] FALSE  TRUE  TRUE  TRUE FALSE

cbind(rep(3,5),rep(4,5)) %)o(% cbind(1:5, 2:6)
#> [1]  TRUE FALSE FALSE FALSE  TRUE
cbind(rep(3,5),rep(4,5)) %[<o]% cbind(1:5, 2:6)
#> [1] FALSE FALSE FALSE FALSE  TRUE
cbind(rep(3,5),rep(4,5)) %[o>]% cbind(1:5, 2:6)
#> [1]  TRUE FALSE FALSE FALSE FALSE

## open intervals

list(0:4, 1:5) %(o)% cbind(rep(2,5), rep(3,5))
#> [1] FALSE FALSE  TRUE FALSE FALSE
cbind(rep(2,5), rep(3,5)) %(o)% list(0:4, 1:5)
#> [1] FALSE FALSE  TRUE FALSE FALSE

cbind(rep(3,5),rep(4,5)) %]o[% cbind(1:5, 2:6)
#> [1]  TRUE  TRUE FALSE  TRUE  TRUE
cbind(rep(3,5),rep(4,5)) %(<o)% cbind(1:5, 2:6)
#> [1] FALSE FALSE FALSE  TRUE  TRUE
cbind(rep(3,5),rep(4,5)) %(o>)% cbind(1:5, 2:6)
#> [1]  TRUE  TRUE FALSE FALSE FALSE

dt1 <- as.Date(c("2000-01-01", "2000-03-15"))
dt2 <- as.Date(c("2000-03-15", "2000-06-07"))

dt1 %[]o[]% dt2
#> [1] TRUE
dt1 %[]o[)% dt2
#> [1] TRUE
dt1 %[]o(]% dt2
#> [1] FALSE
dt1 %[]o()% dt2
#> [1] FALSE
dt1 %[)o[]% dt2
#> [1] FALSE
dt1 %[)o[)% dt2
#> [1] FALSE
dt1 %[)o(]% dt2
#> [1] FALSE
dt1 %[)o()% dt2
#> [1] FALSE
dt1 %(]o[]% dt2
#> [1] TRUE
dt1 %(]o[)% dt2
#> [1] TRUE
dt1 %(]o(]% dt2
#> [1] FALSE
dt1 %(]o()% dt2
#> [1] FALSE
dt1 %()o[]% dt2
#> [1] FALSE
dt1 %()o[)% dt2
#> [1] FALSE
dt1 %()o(]% dt2
#> [1] FALSE
dt1 %()o()% dt2
#> [1] FALSE

## watch precedence
(2 * c(1, 3)) %[o]% (c(2, 4) * 2)
#> [1] TRUE
(2 * c(1, 3)) %[o]% c(2, 4) * 2
#> [1] 2
2 * c(1, 3) %[o]% (c(2, 4) * 2)
#> [1] 0
2 * c(1, 3) %[o]% c(2, 4) * 2
#> [1] 4
```
