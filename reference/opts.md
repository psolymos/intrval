# Global options for the intrval package

Options store and allow to set global values for the intrval functions.

## Usage

``` r
intrval_options(...)
```

## Arguments

- ...:

  Options to set.

## Value

When parameters are set by `intrval_options`, their former values are
returned in an invisible named list. Such a list can be passed as an
argument to `intrval_options` to restore the parameter values. Tags are
the following:

- `use_fpCompare`: use the fpCompare package for the reliable comparison
  of floating point numbers.

## Examples

``` r
str(intrval_options())
#> List of 1
#>  $ use_fpCompare: logi TRUE

x1 <- 0.5 - 0.3
x2 <- 0.3 - 0.1

# save old values and set the new one
op <- intrval_options(use_fpCompare = FALSE)

# this is the base R behavior
x1 
#> [1] 0.2
x2 
#> [1] 0.2

# reset defaults
intrval_options(op)

# using fpCompare
x1 
#> [1] 0.2
x2 
#> [1] 0.2
```
