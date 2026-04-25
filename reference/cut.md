# Dividing a Range Into 3 Intervals

Functions for evaluating if values of vectors are within intervals, or
less than or higher than interval endpoints. The `c` within the brackets
refer to [`cut`](https://rdrr.io/r/base/cut.html), a similar function.

## Usage

``` r
x %[c]% interval
x %[c)% interval
x %(c]% interval
x %(c)% interval
```

## Arguments

- x:

  vector or `NULL`: the values to be compared to interval endpoints.

- interval:

  vector, 2-column matrix, list, or `NULL`: the interval end points.

## Value

Values of `x` are compared to `interval` endpoints a and b (a \<= b)
(see [`%[]%`](intrval.md) for details). The functions return an integer
vector taking values `-1L` (value of `x` is less than or equal to a,
depending on the interval type), `0L` (value of `x` is inside the
interval), or `1L` (value of `x` is greater than or equal to b,
depending on the interval type).

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

Similar functions (but not quite):
[`sign`](https://rdrr.io/r/base/sign.html),
[`cut`](https://rdrr.io/r/base/cut.html),
[`.bincode`](https://rdrr.io/r/base/bincode.html),
[`findInterval`](https://rdrr.io/r/base/findInterval.html).

See relational operators for intervals: [`%[]%`](intrval.md).

See [`Syntax`](https://rdrr.io/r/base/Syntax.html) for operator
precedence.

## Examples

``` r
x <- 1:5
x %[c]% c(2,4)
#> [1] -1  0  0  0  1
x %[c)% c(2,4)
#> [1] -1  0  0  1  1
x %(c]% c(2,4)
#> [1] -1 -1  0  0  1
x %(c)% c(2,4)
#> [1] -1 -1  0  1  1
```
