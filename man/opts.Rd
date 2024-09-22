\name{intrval-options}
\alias{intrval-options}
\alias{intrval_options}
\title{Global options for the intrval package}
\usage{
intrval_options(...)
}
\arguments{
\item{...}{Options to set.}
}
\value{
When parameters are set by \code{intrval_options}, their former values are
returned in an invisible named list. Such a list can be passed as an
argument to \code{intrval_options} to restore the parameter values.
Tags are the following:
\itemize{
\item \code{use_fpCompare}: use the fpCompare package for the reliable comparison of floating point numbers.
}
}
\description{
Options store and allow to set global values for the intrval functions.
}
\examples{
str(intrval_options())

x1 <- 0.5 - 0.3
x2 <- 0.3 - 0.1

# save old values and set the new one
op <- intrval_options(use_fpCompare = FALSE)

# this is the base R behavior
x1 %[]% c(0.2, 0.6) # TRUE
x2 %[]% c(0.2, 0.6) # FALSE

# reset defaults
intrval_options(op)

# using fpCompare
x1 %[]% c(0.2, 0.6) # TRUE
x2 %[]% c(0.2, 0.6) # TRUE

}
