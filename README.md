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

![](https://github.com/psolymos/intrwal/raw/master/extras/intrval.png)

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

