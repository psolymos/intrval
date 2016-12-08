is_empty_interval <- function(interval, type) {
  interval[[1]]==interval[[2]] & type=="()"
}

overlaps <- function (interval1, interval2, type1, type2)
{
    stopifnot(is.vector(interval1) && length(interval1)<=2)
    stopifnot(is.vector(interval2) && length(interval2)<=2)

    iv1 <- .get_intrval(interval1)
    iv2 <- .get_intrval(interval2)

    type1 <- match.arg(type1, c("[]", "[)", "(]", "()"))
    type2 <- match.arg(type2, c("[]", "[)", "(]", "()"))

    if (is_empty_interval(iv1, type1) | is_empty_interval(iv2, type2)) {
      return(FALSE)
    }


    if (iv1$a > iv2$a) {
        tmp <- iv1
        iv1 <- iv2
        iv2 <- tmp

        tmp <- type1
        type1 <- type2
        type2 <- tmp
    }

    !.lssthan(iv1$b, iv2,
        ifelse(substr(type1, 2L, 2L)=="]" && substr(type2, 1L, 1L)=="[",
        "[", "("))
}




library(dplyr, purrr)

mm <- expand.grid(
  iv1_a=c(1, 2, 3, 4, 5),
  iv1_b=c(1, 2, 3, 4, 5),
  iv2_a=c(1, 2, 3, 4, 5),
  iv2_b=c(1, 2, 3, 4, 5),
  type1=c("[]", "[)", "(]", "()"),
  type2=c("[]", "[)", "(]", "()"),
  stringsAsFactors=FALSE)
nrow(mm)

mm %>%
  sample_n(4)

mm %>%
  sample_n(10) %>%
  by_row(~ overlaps(c(.[[1]], .[[2]]), c(.[[3]], .[[4]]),
                    .[[5]], .[[6]]), .collate="cols")

mm %>%
  .[, 1:4] %>%
  sample_n(10) %>%
  by_row(~ c(.[[1]], .[[2]]) %[]o[]% c(.[[3]], .[[4]]), .collate="cols")



library(testthat)
expect_false(overlaps(c(2, 4), c(2, 2), "[]", "()"))
expect_false(overlaps(c(2, 2), c(2, 4), "()", "[]"))



intrval4 <- function (df1)
{
  stopifnot(is.data.frame(df1))
  stopifnot(nrow(df1)==1)

  iv1 <- .get_intrval(c(df1$iv1_a, df1$iv1_b))
  iv2 <- .get_intrval(c(df1$iv2_a, df1$iv2_b))

  type1 <- match.arg(df1$type1, c("[]", "[)", "(]", "()"))
  type2 <- match.arg(df1$type2, c("[]", "[)", "(]", "()"))

  if (is_empty_interval(iv1, type1) | is_empty_interval(iv1, type1)) {
    return (FALSE)
  }

  if (iv1$a > iv2$a) {
    tmp <- iv1
    iv1 <- iv2
    iv2 <- tmp

    tmp <- type1
    type1 <- type2
    type2 <- tmp
  }

  !.lssthan(iv1$b, iv2,
            ifelse(substr(type1, 2L, 2L)=="]" && substr(type2, 1L, 1L)=="[",
                   "[", "("))
}

mm %>%
  sample_n(20) %>%
  by_row(intrval4, .collate=c("cols"))
