\name{\%!in\%}
\alias{\%!in\%}
\title{
Negated Value Matching
}
\description{
\code{\%!in\%} is the negation of \code{\link{\%in\%}},
which returns a logical vector indicating if there is a non-match or not 
for its left operand.
}
\usage{
x \%!in\% table
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
}
\examples{
1:10 \%!in\% c(1,3,5,9)
sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","\%")
sstr[sstr \%!in\% c(letters, LETTERS)]
}
\keyword{manip}
\keyword{logic}
