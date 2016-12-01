\name{\%nin\%}
\alias{\%nin\%}
\title{
Negated Value Matching
}
\description{
\code{\%nin\%} is the negation of \code{\link{\%in\%}},
which returns a logical vector indicating if there is a non-match or not
for its left operand.
}
\usage{
x \%nin\% table
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
}
\examples{
1:10 \%nin\% c(1,3,5,9)
sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","\%")
sstr[sstr \%nin\% c(letters, LETTERS)]
}
\keyword{manip}
\keyword{logic}
