\name{\%ni\%}
\alias{\%ni\%}
\alias{\%nin\%}
\alias{\%notin\%}
\title{
Negated Value Matching
}
\description{
\code{\%ni\%} is the negation of \code{\link{\%in\%}},
which returns a logical vector indicating if there is a non-match or not
for its left operand. \code{\%nin\%} and \code{\%notin\%} are aliases for
better code readability (\code{\%in\%} can look very much like \code{\%ni\%}).
}
\usage{
x \%ni\% table
x \%nin\% table
x \%notin\% table
}
\arguments{
  \item{x}{
vector or \code{NULL}: the values to be matched.
}
  \item{table}{
vector or \code{NULL}: the values to be matched against.
}
}
\value{
A logical vector, indicating if a non-match was located for each element of
\code{x}: thus the values are \code{TRUE} or \code{FALSE} and never \code{NA}.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
All the opposite of what is written for \code{\link{\%in\%}}.

See relational operators for intervals: \code{\link{\%[]\%}}.

See \code{\link{Syntax}} for operator precedence.
}
\examples{
1:10 \%ni\% c(1,3,5,9)
1:10 \%nin\% c(1,3,5,9)
1:10 \%notin\% c(1,3,5,9)

sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","\%")
sstr[sstr \%ni\% c(letters, LETTERS)]
}
\keyword{manip}
\keyword{logic}
