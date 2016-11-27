# intrval: Relational Operators for Intervals

[![CRAN version](http://www.r-pkg.org/badges/version/mefa4)](http://cran.rstudio.com/web/packages/intrval/index.html)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/intrval)](http://cran.rstudio.com/web/packages/intrval/index.html)
[![Linux build Status](https://travis-ci.org/psolymos/intrval.svg?branch=master)](https://travis-ci.org/psolymos/intrval)
[![Windows build status](https://ci.appveyor.com/api/projects/status/a34rcucks4jn7niq?svg=true)](https://ci.appveyor.com/project/psolymos/intrval)
[![Code coverage status](https://codecov.io/gh/psolymos/intrval/branch/master/graph/badge.svg)](https://codecov.io/gh/psolymos/intrval)

Functions for evaluating if values 
of vectors are within intervals
using a `x %()% c(a, b)` style notation for comparing 
values of _x_ with (_a_, _b_) interval to get _a_ < _x_ < _b_ evaluated.
Interval endpoints can be open (`(`, `)`) or closed (`[`, `]`)
including 8 different combinations.

![](https://github.com/psolymos/intrval/raw/master/extras/intrval.png)

Values of `x` are compared to interval endpoints.
Endpoints can be defined as a vector with two values: these values will be compared as a single interval with each value in `x`.
If endpoints are stored in a matrix-like object or a list,
comparisons are made element-wise. If lengths do not match, shorter objects are recycled. Return values are logicals.


```R
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
```

## Versions

Install CRAN version as:

```R
install.packages("intrval")
```

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

