# Negated Value Matching

`%ni%` is the negation of [`%in%`](https://rdrr.io/r/base/match.html),
which returns a logical vector indicating if there is a non-match or not
for its left operand. `%nin%` and `%notin%` are aliases for better code
readability (`%in%` can look very much like `%ni%`).

## Usage

``` r
x %ni% table
x %nin% table
x %notin% table
```

## Arguments

- x:

  vector or `NULL`: the values to be matched.

- table:

  vector or `NULL`: the values to be matched against.

## Value

A logical vector, indicating if a non-match was located for each element
of `x`: thus the values are `TRUE` or `FALSE` and never `NA`.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

All the opposite of what is written for
[`%in%`](https://rdrr.io/r/base/match.html).

See relational operators for intervals: [`%[]%`](intrval.md).

See [`Syntax`](https://rdrr.io/r/base/Syntax.html) for operator
precedence.

## Examples

``` r
1:10 %ni% c(1,3,5,9)
#>  [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE
1:10 %nin% c(1,3,5,9)
#>  [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE
1:10 %notin% c(1,3,5,9)
#>  [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE

sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","%")
sstr[sstr %ni% c(letters, LETTERS)]
#> [1] "ab"  "bba" NA    "@"   "bla" "Ba"  "%"  
```
