# intrval: Relational Operators for Intervals

[![CRAN version](http://www.r-pkg.org/badges/version/intrval)](http://cran.rstudio.com/web/packages/intrval/index.html)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/intrval)](https://www.rdocumentation.org/packages/intrval/)
[![Linux build Status](https://travis-ci.org/psolymos/intrval.svg?branch=master)](https://travis-ci.org/psolymos/intrval)
[![Windows build status](https://ci.appveyor.com/api/projects/status/a34rcucks4jn7niq?svg=true)](https://ci.appveyor.com/project/psolymos/intrval)
[![Code coverage status](https://codecov.io/gh/psolymos/intrval/branch/master/graph/badge.svg)](https://codecov.io/gh/psolymos/intrval)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![Research software impact](http://depsy.org/api/package/cran/intrval/badge.svg)](http://depsy.org/package/r/intrval)
[![Github Stars](https://img.shields.io/github/stars/psolymos/intrval.svg?style=social&label=GitHub)](https://github.com/psolymos/intrval)

Evaluating if values of vectors are within different open/closed intervals
(`x %[]% c(a, b)`), or if two closed
intervals overlap (`c(a1, b1) %[]o[]% c(a2, b2)`).
Operators for negation and directional relations also implemented.

![](https://github.com/psolymos/intrval/raw/master/extras/intrval.png)

## Install

Install from CRAN:

```R
install.packages("intrval")
```

Install development version from GitHub:

```R
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("psolymos/intrval")
```

User visible changes are listed in the [NEWS](https://github.com/psolymos/intrval/blob/master/NEWS.md) file.

Use the [issue tracker](https://github.com/psolymos/intrval/issues) to report a problem.

## Value-to-interval relations

Values of `x` are compared to interval endpoints `a` and `b` (`a <= b`).
Endpoints can be defined as a vector with two values (`c(a, b)`):
these values will be compared as a single interval with each value in `x`.
If endpoints are stored in a matrix-like object or a list,
comparisons are made element-wise.

```R
x <- rep(4, 5)
a <- 1:5
b <- 3:7
cbind(x=x, a=a, b=b)
x %[]% cbind(a, b) # matrix
x %[]% data.frame(a=a, b=b) # data.frame
x %[]% list(a, b) # list
```

If lengths do not match, shorter objects are recycled. Return values are logicals.
Note: interval endpoints are sorted internally thus ensuring the condition
`a <= b` is not necessary.

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

Equal    | Not equal | Less than | Greater than
---------|-----------|-----------|----------------
 `%[]%`  | `%)(%`    | `%[<]%`   | `%[>]%`
 `%[)%`  | `%)[%`    | `%[<)%`   | `%[>)%`
 `%(]%`  | `%](%`    | `%(<]%`   | `%(>]%`
 `%()%`  | `%][%`    | `%(<)%`   | `%(>)%`

### Dividing a range into 3 intervals

The functions `%[c]%`, `%[c)%`, `%(c]%`, and `%(c)%`
return an integer vector taking values
(the `c` within the brackets refer to 'cut'):

* `-1L` when the value is less than or equal to `a` (`a <= b`),
  depending on the interval type,
* `0L` when the value is inside the interval, or
* `1L` when the value is greater than or equal to `b` (`a <= b`),
  depending on the interval type.

 Expression        | Evaluates to -1 | Evaluates to 0    | Evaluates to 1
-------------------|-----------------|-------------------|------------------
 `x %[c]% c(a, b)` | `x < a`         | `x >= a & x <= b` | `x > b`
 `x %[c)% c(a, b)` | `x < a`         | `x >= a & x < b`  | `x >= b`
 `x %(c]% c(a, b)` | `x <= a`        | `x > a & x <= b`  | `x > b`
 `x %(c)% c(a, b)` | `x <= a`        | `x > a & x < b`   | `x >= b`

## Interval-to-interval relations

The operators define the open/closed nature of the lower/upper
limits of the intervals on the left and right hand side of the `o`
in the middle.

Intervals        | Int. 2: `[]` | Int. 2: `[)` | Int. 2: `(]` | Int. 2: `()`
-----------------|--------------|--------------|--------------|--------------
**Int. 1: `[]`** | `%[]o[]%`    | `%[]o[)%`    | `%[]o(]%`    | `%[]o()%`
**Int. 1: `[)`** | `%[)o[]%`    | `%[)o[)%`    | `%[)o(]%`    | `%[)o()%`
**Int. 1: `(]`** | `%(]o[]%`    | `%(]o[)%`    | `%(]o(]%`    | `%(]o()%`
**Int. 1: `()`** | `%()o[]%`    | `%()o[)%`    | `%()o(]%`    | `%()o()%`

The overlap of two closed intervals, [a1, b1] and [a2, b2],
is evaluated by the `%[o]%` (alias for `%[]o[]%`)
operator (`a1 <= b1`, `a2 <= b2`).
Endpoints can be defined as a vector with two values
(`c(a1, b1)`)or can be stored in matrix-like objects or a lists
in which case comparisons are made element-wise.
If lengths do not match, shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates), see Examples.
Note: interval endpoints
are sorted internally thus ensuring the conditions
`a1 <= b1` and `a2 <= b2` is not necessary.

```R
c(2, 3) %[]o[]% c(0, 1)
list(0:4, 1:5) %[]o[]% c(2, 3)
cbind(0:4, 1:5) %[]o[]% c(2, 3)
data.frame(a=0:4, b=1:5) %[]o[]% c(2, 3)
```

If lengths do not match, shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates).

`%)o(%` is used for the negation of two closed interval overlap,
directional evaluation is done via the operators
`%[<o]%` and `%[o>]%`.
The overlap of two open intervals
is evaluated by the `%(o)%` (alias for `%()o()%`).
`%]o[%` is used for the negation of two open interval overlap,
directional evaluation is done via the operators
`%(<o)%` and `%(o>)%`.

Equal     | Not equal  | Less than  | Greater than
----------|------------|------------|----------------
 `%[o]%`  | `%)o(%`    | `%[<o]%`   | `%[o>]%`
 `%(o)%`  | `%]o[%`    | `%(<o)%`   | `%(o>)%`

Overlap operators with mixed endpoint do not have
negation and directional counterparts.

## Operators for discrete variables

The previous operators will return `NA` for unordered factors.
Set overlap can be evaluated by the **base** `%in%` operator and 
its negation `%ni%` (as in *n*ot *i*n, the opposite of in).
`%nin%` and `%notin%` are aliases for
better code readability (`%in%` can look very much like `%ni%`).

## Examples

![](https://github.com/psolymos/intrval/raw/master/extras/examples.png)

### Bounding box

```R
set.seed(1)
n <- 10^4
x <- runif(n, -2, 2)
y <- runif(n, -2, 2)
d <- sqrt(x^2 + y^2)
iv1 <- x %[]% c(-0.25, 0.25) & y %[]% c(-1.5, 1.5)
iv2 <- x %[]% c(-1.5, 1.5) & y %[]% c(-0.25, 0.25)
iv3 <- d %()% c(1, 1.5)
plot(x, y, pch = 19, cex = 0.25, col = iv1 + iv2 + 1,
    main = "Intersecting bounding boxes")
plot(x, y, pch = 19, cex = 0.25, col = iv3 + 1,
     main = "Deck the halls:\ndistance range from center")
```

### Time series filtering

```R
x <- seq(0, 4*24*60*60, 60*60)
dt <- as.POSIXct(x, origin="2000-01-01 00:00:00")
f <- as.POSIXlt(dt)$hour %[]% c(0, 11)
plot(sin(x) ~ dt, type="l", col="grey",
    main = "Filtering date/time objects")
points(sin(x) ~ dt, pch = 19, col = f + 1)
```

### Quality control chart (QCC)

```R
library(qcc)
data(pistonrings)
mu <- mean(pistonrings$diameter[pistonrings$trial])
SD <- sd(pistonrings$diameter[pistonrings$trial])
x <- pistonrings$diameter[!pistonrings$trial]
iv <- mu + 3 * c(-SD, SD)
plot(x, pch = 19, col = x %)(% iv +1, type = "b", ylim = mu + 5 * c(-SD, SD),
    main = "Shewhart quality control chart\ndiameter of piston rings")
abline(h = mu)
abline(h = iv, lty = 2)
```

### Confidence intervals and hypothesis testing

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
```

### Dates

```R
DATE <- as.Date(c("2000-01-01","2000-02-01", "2000-03-31"))
DATE %[<]% as.Date(c("2000-01-15", "2000-03-15"))
# [1]  TRUE FALSE FALSE
DATE %[]% as.Date(c("2000-01-15", "2000-03-15"))
# [1] FALSE  TRUE FALSE
DATE %[>]% as.Date(c("2000-01-15", "2000-03-15"))
# [1] FALSE FALSE  TRUE

dt1 <- as.Date(c("2000-01-01", "2000-03-15"))
dt2 <- as.Date(c("2000-03-15", "2000-06-07"))
dt1 %[]o[]% dt2
# [1] TRUE
dt1 %[]o[)% dt2
# [1] TRUE
dt1 %[]o(]% dt2
# [1] FALSE
dt1 %[]o()% dt2
# [1] FALSE
```

### Watch precedence!

```R
(2 * 1:5) %[]% (c(2, 3) * 2)
# [1] FALSE  TRUE  TRUE FALSE FALSE
2 * 1:5 %[]% (c(2, 3) * 2)
# [1] 0 0 0 2 2
(2 * 1:5) %[]% c(2, 3) * 2
# [1] 2 0 0 0 0
2 * 1:5 %[]% c(2, 3) * 2
# [1] 0 4 4 0 0
```

### Truncated distributions

![](https://github.com/psolymos/intrval/raw/master/extras/dtrunc.png)

Find the math [here](http://www.jstatsoft.org/v16/c02),
as implemented in the package 
[**truncdist**](https://CRAN.R-project.org/package=truncdist).

```R
dtrunc <- function(x, ..., distr, lwr=-Inf, upr=Inf) {
    f <- get(paste0("d", distr), mode = "function")
    F <- get(paste0("p", distr), mode = "function")
    Fx_lwr <- F(lwr, ..., log=FALSE)
    Fx_upr <- F(upr, ..., log=FALSE)
    fx     <- f(x,   ..., log=FALSE)
    fx / (Fx_upr - Fx_lwr) * (x %[]% c(lwr, upr))
}
n <- 10^4
curve(dtrunc(x, distr="norm"), -2.5, 2.5, ylim=c(0, 2), ylab="f(x)")
curve(dtrunc(x, distr="norm", lwr=-0.5, upr=0.1), add=TRUE, col=4, n=n)
curve(dtrunc(x, distr="norm", lwr=-0.75, upr=0.25), add=TRUE, col=3, n=n)
curve(dtrunc(x, distr="norm", lwr=-1, upr=1), add=TRUE, col=2, n=n)
```

### Shiny example 1: regular slider


![](https://github.com/psolymos/intrval/raw/master/extras/regular_slider.gif)

```R
library(shiny)
library(intrval)
library(qcc)

data(pistonrings)
mu <- mean(pistonrings$diameter[pistonrings$trial])
SD <- sd(pistonrings$diameter[pistonrings$trial])
x <- pistonrings$diameter[!pistonrings$trial]

## UI function
ui <- fluidPage(
  plotOutput("plot"),
  sliderInput("x", "x SD:",
    min=0, max=5, value=0, step=0.1,
    animate=animationOptions(100)
  )
)

# Server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    Main <- paste("Shewhart quality control chart", 
        "diameter of piston rings", sprintf("+/- %.1f SD", input$x),
        sep="\n")
    iv <- mu + input$x * c(-SD, SD)
    plot(x, pch = 19, col = x %)(% iv +1, type = "b", 
        ylim = mu + 5 * c(-SD, SD), main = Main)
    abline(h = mu)
    abline(h = iv, lty = 2)
  })
}

## Run shiny app
if (interactive()) shinyApp(ui, server)
```

### Shiny example 2: range slider


![](https://github.com/psolymos/intrval/raw/master/extras/range_slider.gif)

```R
library(shiny)
library(intrval)

set.seed(1)
n <- 10^4
x <- round(runif(n, -2, 2), 2)
y <- round(runif(n, -2, 2), 2)
d <- round(sqrt(x^2 + y^2), 2)

## UI function
ui <- fluidPage(
  titlePanel("intrval example with shiny"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bb_x", "x value:",
        min=min(x), max=max(x), value=range(x), 
        step=round(diff(range(x))/20, 1), animate=TRUE
      ),
      sliderInput("bb_y", "y value:",
        min = min(y), max = max(y), value = range(y),
        step=round(diff(range(y))/20, 1), animate=TRUE
      ),
      sliderInput("bb_d", "radial distance:",
        min = 0, max = max(d), value = c(0, max(d)/2),
        step=round(max(d)/20, 1), animate=TRUE
      )
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    iv1 <- x %[]% input$bb_x & y %[]% input$bb_y
    iv2 <- x %[]% input$bb_y & y %[]% input$bb_x
    iv3 <- d %()% input$bb_d
    op <- par(mfrow=c(1,2))
    plot(x, y, pch = 19, cex = 0.25, col = iv1 + iv2 + 3,
        main = "Intersecting bounding boxes")
    plot(x, y, pch = 19, cex = 0.25, col = iv3 + 1,
         main = "Deck the halls:\ndistance range from center")
    par(op)
  })
}

## Run shiny app
if (interactive()) shinyApp(ui, server)
```
