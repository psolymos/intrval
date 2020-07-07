\name{\%[c]\%}
\alias{\%[c]\%}
\alias{\%[c)\%}
\alias{\%(c]\%}
\alias{\%(c)\%}
\title{
Dividing a Range Into 3 Intervals
}
\description{
Functions for evaluating if values of vectors are within intervals,
or less than or higher than interval endpoints.
The \code{c} within the brackets refer to \code{\link{cut}},
a similar function.
}
\usage{
x \%[c]\% interval
x \%[c)\% interval
x \%(c]\% interval
x \%(c)\% interval
}
\arguments{
  \item{x}{
vector or \code{NULL}: the values to be compared to interval endpoints.
}
  \item{interval}{
vector, 2-column matrix, list, or \code{NULL}: the interval end points.
}
}
\value{
Values of \code{x} are compared to \code{interval} endpoints
a and b (a <= b) (see \code{\link{\%[]\%}} for details).
The functions return an integer vector taking values
\code{-1L} (value of \code{x} is less than or equal to a,
depending on the interval type),
\code{0L} (value of \code{x} is inside the interval), or
\code{1L} (value of \code{x} is greater than or equal to b,
depending on the interval type).
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
Similar functions (but not quite): \code{\link{sign}},
\code{\link{cut}}, \code{\link{.bincode}}, \code{\link{findInterval}}.

See relational operators for intervals: \code{\link{\%[]\%}}.

See \code{\link{Syntax}} for operator precedence.
}
\examples{
x <- 1:5
x \%[c]\% c(2,4)
x \%[c)\% c(2,4)
x \%(c]\% c(2,4)
x \%(c)\% c(2,4)
}
\keyword{manip}
