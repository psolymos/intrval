\name{ovrlap}
\alias{overlap}
\alias{\%[o]\%}
\alias{\%)o(\%}
\alias{\%[<o]\%}
\alias{\%[o>]\%}
\alias{\%(o)\%}
\alias{\%[]o[]\%}
\alias{\%[]o[)\%}
\alias{\%[]o(]\%}
\alias{\%[]o()\%}
\alias{\%[)o[]\%}
\alias{\%[)o[)\%}
\alias{\%[)o(]\%}
\alias{\%[)o()\%}
\alias{\%(]o[]\%}
\alias{\%(]o[)\%}
\alias{\%(]o(]\%}
\alias{\%(]o()\%}
\alias{\%()o[]\%}
\alias{\%()o[)\%}
\alias{\%()o(]\%}
\alias{\%()o()\%}
\title{
Relational Operators Comparing Two Intervals
}
\description{
Function for evaluating if two closed intervals overlap or not.
}
\usage{
interval1 \%[o]\% interval2
interval1 \%)o(\% interval2
interval1 \%[<o]\% interval2
interval1 \%[o>]\% interval2

interval1 \%(o)\% interval2

interval1 \%[]o[]\% interval2
interval1 \%[]o[)\% interval2
interval1 \%[]o(]\% interval2
interval1 \%[]o()\% interval2
interval1 \%[)o[]\% interval2
interval1 \%[)o[)\% interval2
interval1 \%[)o(]\% interval2
interval1 \%[)o()\% interval2
interval1 \%(]o[]\% interval2
interval1 \%(]o[)\% interval2
interval1 \%(]o(]\% interval2
interval1 \%(]o()\% interval2
interval1 \%()o[]\% interval2
interval1 \%()o[)\% interval2
interval1 \%()o(]\% interval2
interval1 \%()o()\% interval2
}
\arguments{
  \item{interval1, interval2}{
vector, 2-column matrix, list, or \code{NULL}: the interval end points
of two (sets) of closed intervals to compare.
}
}
\details{
The operators define the open/closed nature of the lower/upper
limits of the intervals on the left and right hand side of the \code{o}
in the middle.

The overlap of two open intervals
is evaluated by the \code{\%(o)\%} (alias for \code{\%()o()\%}).

The overlap of two closed intervals, [a1, b1] and [a2, b2],
is evaluated by the \code{\%[o]\%} (alias for \code{\%[]o[]\%})
operator (a1 <= b1, a2 <= b2).
Endpoints can be defined as a vector with two values
(\code{c(a1, b1)})or can be stored in matrix-like objects or a lists
in which case comparisons are made element-wise.
If lengths do not match, shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates), see Examples.
Note: interval endpoints
are sorted internally thus ensuring the conditions
a1 <= b1 and a2 <= b2 is not necessary.

\code{\%)o(\%} is used for the negation of two closed interval overlap,
directional evaluation is done via the operators
\code{\%[<o]\%} and \code{\%[o>]\%}.
}
\value{
A logical vector, indicating if \code{interval1} overlaps \code{interval2}.
Values are \code{TRUE}, \code{FALSE}, or \code{NA}.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
See help page for relational operators: \code{\link{Comparison}}.

See \code{\link{\%[]\%}} for relational operators for
value-to-interval comparisons.

See \code{\link{factor}} for the behavior with factor arguments.
See also \code{\link{\%in\%}} for value matching
and \code{\link{\%ni\%}} for negated value matching
for factors.
}
\examples{
## motivating examples from example(lm)

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept
## compare 95\% confidence of the 2 groups to each other
(CI.D90 <- confint(lm.D90))
CI.D90[1,] \%[o]\% CI.D90[2,]

## simple interval comparisons
c(2:3) \%[o]\% c(0:1)

## vectorized comparisons
c(2:3) \%[o]\% list(0:4, 1:5)
c(2:3) \%[o]\% cbind(0:4, 1:5)
c(2:3) \%[o]\% data.frame(a=0:4, b=1:5)
list(0:4, 1:5) \%[o]\% c(2:3)
cbind(0:4, 1:5) \%[o]\% c(2:3)
data.frame(a=0:4, b=1:5) \%[o]\% c(2:3)

list(0:4, 1:5) \%[o]\% cbind(rep(2,5), rep(3,5))
cbind(rep(2,5), rep(3,5)) \%[o]\% list(0:4, 1:5)

cbind(rep(3,5),rep(4,5)) \%[o]\% cbind(1:5, 2:6)
cbind(rep(3,5),rep(4,5)) \%[<o]\% cbind(1:5, 2:6)
cbind(rep(3,5),rep(4,5)) \%[o>]\% cbind(1:5, 2:6)

c(1,3) \%[)o(]\% c(3,4)
## fixme: add more and meaningful examples, e.g. dates.
}
\keyword{manip}
\keyword{logic}
