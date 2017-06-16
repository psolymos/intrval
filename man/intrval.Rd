\name{intrval}
\alias{intrval}
\alias{interval}
\alias{\%[]\%}
\alias{\%[)\%}
\alias{\%(]\%}
\alias{\%()\%}
\alias{\%][\%}
\alias{\%](\%}
\alias{\%)[\%}
\alias{\%)(\%}
\alias{\%[<]\%}
\alias{\%[<)\%}
\alias{\%(<]\%}
\alias{\%(<)\%}
\alias{\%[>]\%}
\alias{\%[>)\%}
\alias{\%(>]\%}
\alias{\%(>)\%}
\alias{intrval_types}
\title{
Relational Operators Comparing Values to Intervals
}
\description{
Functions for evaluating if values of vectors are within intervals.
}
\usage{
x \%[]\% interval
x \%)(\% interval
x \%[<]\% interval
x \%[>]\% interval

x \%[)\% interval
x \%)[\% interval
x \%[<)\% interval
x \%[>)\% interval

x \%(]\% interval
x \%](\% interval
x \%(<]\% interval
x \%(>]\% interval

x \%()\% interval
x \%][\% interval
x \%(<)\% interval
x \%(>)\% interval

intrval_types(type = NULL, plot = FALSE)
}
\arguments{
  \item{x}{
vector or \code{NULL}: the values to be compared to interval endpoints.
}
  \item{interval}{
vector, 2-column matrix, list, or \code{NULL}: the interval end points.
}
  \item{type}{
character, type of operator for subsetting the results. The default \code{NULL}
means that all types will be displayed.
}
  \item{plot}{
logical, whether to plot the results, or print a table to the console instead.
}
}
\details{
Values of \code{x} are compared to \code{interval} endpoints
a and b (a <= b).
Endpoints can be defined as a vector with two values
(\code{c(a, b)}): these values will be compared as a single
interval with each value in \code{x}.
If endpoints are stored in a matrix-like object or a list,
comparisons are made element-wise. If lengths do not match,
shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates), see Examples.
Note: interval endpoints are sorted internally thus ensuring the condition
a <= b is not necessary.

Values of \code{x} are compared to \code{interval} endpoints.
The \code{type} argument or the specification of the special function
determines the open (\code{(} and \code{)}) or
closed (\code{[} and \code{]}) endpoints and relations.

There are four types of intervals (\code{[]}, \code{[)}, \code{(]}, \code{()}),
their negation (\code{)(}, \code{)[}, \code{](}, \code{][}, respectively),
less than (\code{[<]}, \code{[<)}, \code{(<]}, \code{(<)}),
and greater than (\code{[>]}, \code{[>)}, \code{(>]}, \code{(>)}) relations.

Note that some operators return identical results but
are syntactically different:
\code{\%[<]\%} and \code{\%[<)\%} both evaluate \code{x < a};
\code{\%[>]\%} and \code{\%(>]\%} both evaluate \code{x > b};
\code{\%(<]\%} and \code{\%(<)\%} evaluate \code{x <= a};
\code{\%[>)\%} and \code{\%(>)\%} both evaluate \code{x >= b}.
This is so because we evaluate only one end of the interval
but still conceptually referring to the relationship
defined by the right-hand-side \code{interval} object
and given that a <= b.
This implies 2 conditional logical evaluations
instead of treating it as a single 3-level ordered factor.
}
\value{
A logical vector, indicating if \code{x} is in the interval specified.
Values are \code{TRUE}, \code{FALSE}, or \code{NA}
(when any of the 3 values (\code{x} or endpoints in \code{interval})
is \code{NA}).

The helper function \code{intrval_types}
can be used to understand and visualize the operators effects.
It returns a matrix explaining the properties of the operators.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
See help page for relational operators: \code{\link{Comparison}}.

See \code{\link{\%[o]\%}} for relational operators for
interval-to-interval comparisons.

See \code{\link{factor}} for the behavior with factor arguments.
See also \code{\link{\%in\%}} for value matching
and \code{\link{\%\%}} for negated value matching
for factors.

See \code{\link{Syntax}} for operator precedence.
}
\examples{
## motivating example from example(lm)

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
## compare 95\% confidence intervals with 0
(CI.D9 <- confint(lm.D9))
0 \%[]\% CI.D9

## comparing dates

DATE <- as.Date(c("2000-01-01","2000-02-01", "2000-03-31"))
DATE \%[<]\% as.Date(c("2000-01-151", "2000-03-15"))
DATE \%[]\% as.Date(c("2000-01-151", "2000-03-15"))
DATE \%[>]\% as.Date(c("2000-01-151", "2000-03-15"))

## interval formats

x <- rep(4, 5)
a <- 1:5
b <- 3:7
cbind(x=x, a=a, b=b)
x \%[]\% cbind(a, b) # matrix
x \%[]\% data.frame(a=a, b=b) # data.frame
x \%[]\% list(a, b) # list

## helper functions

intrval_types() # print
intrval_types(plot = TRUE) # plot

## graphical examples

## bounding box
set.seed(1)
n <- 10^4
x <- runif(n, -2, 2)
y <- runif(n, -2, 2)
iv1 <- x \%[]\% c(-1, 1) & y \%[]\% c(-1, 1)
plot(x, y, pch = 19, cex = 0.25, col = iv1 + 1, main = "Bounding box")

## time series filtering
x <- seq(0, 4*24*60*60, 60*60)
dt <- as.POSIXct(x, origin="2000-01-01 00:00:00")
f <- as.POSIXlt(dt)$hour \%[]\% c(0, 11)
plot(sin(x) ~ dt, type="l", col="grey",
    main = "Filtering date/time objects")
points(sin(x) ~ dt, pch = 19, col = f + 1)

## watch precedence
(2 * 1:5) \%[]\% (c(2, 3) * 2)
2 * 1:5 \%[]\% (c(2, 3) * 2)
(2 * 1:5) \%[]\% c(2, 3) * 2
2 * 1:5 \%[]\% c(2, 3) * 2
}
\keyword{manip}
\keyword{logic}
