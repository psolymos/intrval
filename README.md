# intrval: Relational Operators for Intervals

[![CRAN version](http://www.r-pkg.org/badges/version/intrval)](http://cran.rstudio.com/web/packages/intrval/index.html)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/intrval)](http://cran.rstudio.com/web/packages/intrval/index.html)
[![Linux build Status](https://travis-ci.org/psolymos/intrval.svg?branch=master)](https://travis-ci.org/psolymos/intrval)
[![Windows build status](https://ci.appveyor.com/api/projects/status/a34rcucks4jn7niq?svg=true)](https://ci.appveyor.com/project/psolymos/intrval)
[![Code coverage status](https://codecov.io/gh/psolymos/intrval/branch/master/graph/badge.svg)](https://codecov.io/gh/psolymos/intrval)

Functions for evaluating if values 
of vectors are within intervals
using a `x %()% c(a, b)` style notation for comparing 
values of _x_ with (_a_, _b_) interval to get _a_ < _x_ < _b_ evaluated.
Interval endpoints can be open (`(`, `)`) or closed (`[`, `]`).

![](https://github.com/psolymos/intrval/raw/master/extras/intrval.png)

## Value-to-interval relations

Values of `x` are compared to interval endpoints `a` and `b` (`a <= b`).
Endpoints can be defined as a vector with two values (`c(a, b)`): these values will be compared as a single interval with each value in `x`.
If endpoints are stored in a matrix-like object or a list,
comparisons are made element-wise. If lengths do not match, shorter objects are recycled. Return values are logicals.

These value-to-interval operators work for numeric (integer, real) and ordered vectors, and object types which are measured at least on ordinal scale (e.g. dates).

### Closed and open intervals

The following special operators are used to indicate closed (`[`, `]`) or open (`(`, `)`) interval endpoints: 

Operator | Expression       | Condition
---------|------------------|-------------------
 `%[]%`  | `x %[]% c(a, b)` | `x >= a & x <= b`
 `%[)%`  | `x %[)% c(a, b)` | `x >= a & x < b`
 `%(]%`  | `x %(]% c(a, b)` | `x > a & x <= b`
 `%()%`  | `x %()% c(a, b)` | `x > a & x < b`

### Negation and directional relations

Eqal     | Not equal | Less than | Greater than
---------|-----------|-----------|----------------
 `%[]%`  | `%)(%`    | `%[<]%`   | `%[>]%` 
 `%[)%`  | `%)[%`    | `%[<)%`   | `%[>)%` 
 `%(]%`  | `%](%`    | `%(<]%`   | `%(>]%` 
 `%()%`  | `%][%`    | `%(<)%`   | `%(>)%` 

## Interval-to-interval relations

The overlap or two closed intervals, [`a1`, `b1`] and [`a2`, `b2`], 
is evaluated by the `%[o]%` operator. `%)o(%` is used for the negation,
directional evaluation is done via the operators `%[<o]%` and `%[o>]%`.

## Operators for discrete variables

The previous operators will return `NA` for unordered factors.
Set overlap can be evaluated by the base `%in%` operator and its negation
`%notin%`.

```R
## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)

lm.D9 <- lm(weight ~ group)
## compare 95% confidence intervals with 0
(CI.D9 <- confint(lm.D9))
#                2.5 %    97.5 %
# (Intercept)  4.56934 5.4946602
# groupTrt    -1.02530 0.2833003
0 %[]% CI.D9
# (Intercept)    groupTrt 
#       FALSE        TRUE 

lm.D90 <- lm(weight ~ group - 1) # omitting intercept
## compare 95% confidence of the 2 groups to each other
(CI.D90 <- confint(lm.D90))
#            2.5 %  97.5 %
# groupCtl 4.56934 5.49466
# groupTrt 4.19834 5.12366
CI.D90[1,] %[o]% CI.D90[2,]
# 2.5 % 
#  TRUE 

DATE <- as.Date(c("2000-01-01","2000-02-01", "2000-03-31"))
DATE %[<]% as.Date(c("2000-01-151", "2000-03-15"))
# [1]  TRUE FALSE FALSE
DATE %[]% as.Date(c("2000-01-151", "2000-03-15"))
# [1] FALSE  TRUE FALSE
DATE %[>]% as.Date(c("2000-01-151", "2000-03-15"))
# [1] FALSE FALSE  TRUE

## simple case with integers
1:5 %[]% c(2,4)
# [1] FALSE  TRUE  TRUE  TRUE FALSE
1:5 %[)% c(2,4)
# [1] FALSE  TRUE  TRUE FALSE FALSE
1:5 %(]% c(2,4)
# [1] FALSE FALSE  TRUE  TRUE FALSE
1:5 %()% c(2,4)
# [1] FALSE FALSE  TRUE FALSE FALSE

1:5 %][% c(2,4)
# [1]  TRUE  TRUE FALSE  TRUE  TRUE
1:5 %](% c(2,4)
# [1]  TRUE  TRUE FALSE FALSE  TRUE
1:5 %)[% c(2,4)
# [1]  TRUE FALSE FALSE  TRUE  TRUE
1:5 %)(% c(2,4)
# [1]  TRUE FALSE FALSE FALSE  TRUE

## interval formats
x <- rep(4, 5)
a <- 1:5
b <- 3:7
cbind(x=x, a=a, b=b)
#      x a b
# [1,] 4 1 3
# [2,] 4 2 4
# [3,] 4 3 5
# [4,] 4 4 6
# [5,] 4 5 7
x %[]% cbind(a, b) # matrix
# [1] FALSE  TRUE  TRUE  TRUE FALSE
x %[]% data.frame(a=a, b=b) # data.frame
# [1] FALSE  TRUE  TRUE  TRUE FALSE
x %[]% list(a, b) # list
# [1] FALSE  TRUE  TRUE  TRUE FALSE

## numeric
((1:5)+0.5) %[]% (c(2,4)+0.5)
# [1] FALSE  TRUE  TRUE  TRUE FALSE

## character
c('a','b','c','d','e') %[]% c('b','d')
# [1] FALSE  TRUE  TRUE  TRUE FALSE

## ordered
as.ordered(c('a','b','c','d','e')) %[]% c('b','d')
# [1] FALSE  TRUE  TRUE  TRUE FALSE

## factor -- leads to NA with warnings
as.factor(c('a','b','c','d','e')) %[]% c('b','d')
# [1] NA NA NA NA NA
# Warning messages:
# 1: In Ops.factor(x, a) : ‘>=’ not meaningful for factors
# 2: In Ops.factor(x, b) : ‘<=’ not meaningful for factors

## dates
as.Date(1:5,origin='2000-01-01') %[]% as.Date(c(2,4),origin='2000-01-01')
# [1] FALSE  TRUE  TRUE  TRUE FALSE

## testing overlap
cbind(rep(3,5),rep(4,5)) %[o]% cbind(1:5, 2:6)
# [1] FALSE  TRUE  TRUE  TRUE FALSE
cbind(rep(3,5),rep(4,5)) %[<o]% cbind(1:5, 2:6)
# [1] FALSE FALSE FALSE FALSE  TRUE
cbind(rep(3,5),rep(4,5)) %[o>]% cbind(1:5, 2:6)
# [1]  TRUE FALSE FALSE FALSE FALSE
```

## Versions

Install development version from GitHub:

```R
library(devtools)
install_github("psolymos/intrval")
```

User visible changes are listed in the [NEWS](https://github.com/psolymos/intrval/blob/master/NEWS.md) file.

## Report a problem

Use the [issue tracker](https://github.com/psolymos/intrval/issues)
to report a problem.

## License

[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

