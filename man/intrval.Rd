\name{intrval}
\alias{intrval-package}
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
\alias{\%[o]\%}
\alias{\%)o(\%}
\alias{\%[<o]\%}
\alias{\%[o>]\%}
\alias{intrval_types}
\alias{print_intrval}
\alias{plot_intrval}
\title{
Relational Operators for Intervals
}
\description{
Function for evaluating if values of vectors are within intervals
or if intervals overlap or not.
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

interval1 \%[o]\% interval2
interval1 \%)o(\% interval2
interval1 \%[<o]\% interval2
interval1 \%[o>]\% interval2

intrval_types(type = NULL)
print_intrval(type = NULL)
plot_intrval(type = NULL)
}
\arguments{
  \item{x}{
vector or \code{NULL}: the values to be compared to interval endpoints.
}
  \item{interval}{
vector, 2-column matrix, list, or \code{NULL}: the interval end points.
}
  \item{interval1, interval2}{
vector, 2-column matrix, list, or \code{NULL}: the interval end points
of two (sets) of closed intervals to compare.
}
  \item{type}{
character, any of
\code{"[]"}, \code{"[)"}, \code{"(]"}, \code{"()"},
\code{"]["}, \code{"]("}, \code{")["}, \code{")("}.
}
}
\details{
Values of \code{x} are compared to \code{interval} endpoints.
The \code{type} argument or the specification of the special function
determines the open (\code{(} and \code{)}) or closed (\code{[]} and \code{]})
endpoints and relations.

Endpoints can be defined as a vector with two values: these values will be compared as a single interval with each value in `x`.
If endpoints are stored in a matrix-like object or a list,
comparisons are made element-wise. If lengths do not match, shorter objects are recycled.

\code{\%[o]\%} compares two (sets) of closed intervals,
shorter objects are recycled.
}
\value{
A logical vector, indicating if \code{x} is in the interval specified.
Values are \code{TRUE}, \code{FALSE}, or \code{NA}.

The helper functions \code{print_intrval} and \code{plot_intrval}
can be used to understand and visualize the operators effects.
These return a matrix with expaining the operators.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
See help page for relational operators: \code{\link{Comparison}}.

See \code{\link{factor}} for the behaviour with factor arguments.
See also \code{\link{\%in\%}} for value matching
and \code{\link{\%notin\%}} for negated value matching
for factors.
}
\examples{
## --- motivating examples from example(lm) ---

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)

lm.D9 <- lm(weight ~ group)
## compare 95\% confidence intervals with 0
(CI.D9 <- confint(lm.D9))
0 %[]% CI.D9

lm.D90 <- lm(weight ~ group - 1) # omitting intercept
## compare 95\% confidence of the 2 groups to each other
(CI.D90 <- confint(lm.D90))
CI.D90[1,] %[o]% CI.D90[2,]

DATE <- as.Date(c("2000-01-01","2000-02-01", "2000-03-31"))
DATE %[<]% as.Date(c("2000-01-151", "2000-03-15"))
DATE %[]% as.Date(c("2000-01-151", "2000-03-15"))
DATE %[>]% as.Date(c("2000-01-151", "2000-03-15"))

## --- not so motivating but still useful examples ---

## simple case with integers
1:5 %[]% c(2,4)
1:5 %[)% c(2,4)
1:5 %(]% c(2,4)
1:5 %()% c(2,4)

1:5 %][% c(2,4)
1:5 %](% c(2,4)
1:5 %)[% c(2,4)
1:5 %)(% c(2,4)

## interval formats
x <- rep(4, 5)
a <- 1:5
b <- 3:7
cbind(x=x, a=a, b=b)
x %[]% cbind(a, b) # matrix
x %[]% data.frame(a=a, b=b) # data.frame
x %[]% list(a, b) # list

## NULL
NULL %[]% c(1,2)
NULL %[]% NULL
NULL %[]% list(NULL, NULL)

## logical
c(TRUE, FALSE) %[]% c(TRUE, TRUE)
c(TRUE, FALSE) %[]% c(FALSE, FALSE)
c(TRUE, FALSE) %[]% c(TRUE, FALSE)
c(TRUE, FALSE) %[]% c(FALSE, TRUE)

## NA values
1:5 %[]% c(NA,4)
1:5 %[]% c(2,NA)
c(1:5, NA) %[]% c(2,4)
NA %[]% c(1,2)
NA %[]% c(NA,NA)

## numeric
((1:5)+0.5) %[]% (c(2,4)+0.5)

## character
c('a','b','c','d','e') %[]% c('b','d')

## ordered
as.ordered(c('a','b','c','d','e')) %[]% c('b','d')

## factor -- leads to NA with warnings
as.factor(c('a','b','c','d','e')) %[]% c('b','d')

## dates
as.Date(1:5,origin='2000-01-01') %[]% as.Date(c(2,4),origin='2000-01-01')

## helper functions
print_intrval()
plot_intrval()

## recycling values
1:10 %[]% list(1:5, 6)

## overlap: simple interval comparisons

c(2:3) %[o]% c(0:1)
c(2:3) %[o]% c(1:2)
c(2:3) %[o]% c(2:3)
c(2:3) %[o]% c(3:4)
c(2:3) %[o]% c(4:5)

c(0:1) %[o]% c(2:3)
c(1:2) %[o]% c(2:3)
c(2:3) %[o]% c(2:3)
c(3:4) %[o]% c(2:3)
c(4:5) %[o]% c(2:3)

## overlap: vectorized versions
c(2:3) %[o]% list(0:4, 1:5)
c(2:3) %[o]% cbind(0:4, 1:5)
c(2:3) %[o]% data.frame(a=0:4, b=1:5)
list(0:4, 1:5) %[o]% c(2:3)
cbind(0:4, 1:5) %[o]% c(2:3)
data.frame(a=0:4, b=1:5) %[o]% c(2:3)

list(0:4, 1:5) %[o]% cbind(rep(2,5), rep(3,5))
cbind(rep(2,5), rep(3,5)) %[o]% list(0:4, 1:5)

## directional relations

1:4 %[]% c(2,3)
1:4 %[>]% c(2,3)
1:4 %[<]% c(2,3)

1:4 %[)% c(2,3)
1:4 %[>)% c(2,3)
1:4 %[<)% c(2,3)

1:4 %(]% c(2,3)
1:4 %(>]% c(2,3)
1:4 %(<]% c(2,3)

1:4 %()% c(2,3)
1:4 %(>)% c(2,3)
1:4 %(<)% c(2,3)

cbind(rep(3,5),rep(4,5)) %[o]% cbind(1:5, 2:6)
cbind(rep(3,5),rep(4,5)) %[<o]% cbind(1:5, 2:6)
cbind(rep(3,5),rep(4,5)) %[o>]% cbind(1:5, 2:6)

}
\keyword{manip}
\keyword{logic}
