\name{intrval}
\alias{intrval}
\alias{\%[]\%}
\alias{\%[)\%}
\alias{\%(]\%}
\alias{\%()\%}
\alias{\%][\%}
\alias{\%](\%}
\alias{\%)[\%}
\alias{\%)(\%}
\alias{intrval_types}
\alias{print_intrval}
\alias{plot_intrval}
\title{
Relational Operators for Intervals
}
\description{
Function for evaluating if values of vectors are within intervals.
}
\usage{
intrval(x, interval, type)

x \%[]\% interval
x \%[)\% interval
x \%(]\% interval
x \%()\% interval

x \%][\% interval
x \%](\% interval
x \%)[\% interval
x \%)(\% interval

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
  \item{type}{
character, one of
\code{"[]"}, \code{"[)"}, \code{"(]"}, \code{"()"},
\code{"]["}, \code{"]("}, \code{")["}, \code{")("}.
}
}
\details{
Values of \code{x} are compared to \code{interval} endpoints.
The \code{type} argument or the specification of the special function
determines the open (\code{(} and \code{)}) or closed (\code{[]} and \code{]})
endpoints and relations.
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
}
\examples{
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
}
\keyword{manip}
\keyword{logic}
