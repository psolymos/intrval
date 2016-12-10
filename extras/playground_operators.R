library(testthat)


.reverse_type <- function (type) {
  ifelse(type=="(]", "[)",
         ifelse(type=="[)", "(]", type))
}

.is_empty_interval <- function(interval, type) {
  interval[[1]]==interval[[2]] & type %in% c("()", "[)", "(]")
}


.intrval <- function (x, interval, type) {
  type <- lapply(type, function(x)
    match.arg(x, c("[]", "[)", "(]", "()", "][", "](", ")[", ")(")))
  type <- ifelse(interval[[1]]<=interval[[2]], type, .reverse_type(type))

  type_a <- substr(type, 1L, 1L)
  type_b <- substr(type, 2L, 2L)
  ab <- .get_intrval(interval)
  A <- ifelse(type_a=="[", x >= ab$a,
              ifelse(type_a=="]",x <= ab$a,
                     ifelse(type_a=="(", x > ab$a,
                            ifelse(type_a==")", x < ab$a,
                                   NA))))
  B <- ifelse(type_b=="[", x >= ab$b,
              ifelse(type_b=="]", x <= ab$b,
                     ifelse(type_b=="(", x > ab$b,
                            ifelse(type_b==")", x < ab$b,
                                   NA))))
  print(A & B)
  A & B
}
expect_false(.intrval(4, c(4, 5), "(]"))
expect_false(.intrval(4, c(5, 4), "[)"))


.get_intrval <- function(interval) {
  if (!is.null(dim(interval))) {
    if (ncol(interval) > 2L)
      warning("only first 2 columns of interval object are used")
  } else {
    if (length(interval) > 2L)
      warning("only first 2 elements of interval object are used")
  }

  list(a=pmin(interval[[1]], interval[[2]], na.rm=FALSE),
       b=pmax(interval[[1]], interval[[2]], na.rm=FALSE))
}
expect_warning(.get_intrval(c(5, 3, 3)))
expect_warning(.get_intrval(as.list(c(5, 3, 3), c(2, 1))))
expect_warning(.get_intrval(data.frame(c(5, 3), c(2, 1), c(1, 1))))


.intrval3 <- function(interval1, interval2, type1, type2)
{
  iv1 <- .get_intrval(interval1)
  iv2 <- .get_intrval(interval2)

  type1 <- lapply(type1, function(x) match.arg(x, c("[]", "[)", "(]", "()")))
  type2 <- lapply(type2, function(x) match.arg(x, c("[]", "[)", "(]", "()")))

  type1 <- ifelse(interval1[[1]]<=interval1[[2]], type1, .reverse_type(type1))
  type2 <- ifelse(interval2[[1]]<=interval2[[2]], type2, .reverse_type(type2))

  ifelse(.is_empty_interval(iv1, type1) | .is_empty_interval(iv2, type2),
         FALSE,
         ifelse(iv1$a==iv2$a & iv1$b==iv2$b, TRUE,
                ifelse(iv1$a < iv2$a | (iv1$a==iv2$a & iv1$b < iv2$b),
                       .intrval(iv1$b, iv2,
                                ifelse(substr(type1, 2, 2)=="]", type2, "(]"))
                       | .intrval(iv2$a, iv1,
                                  ifelse(substr(type2, 1, 1)=="[", type1, "[)")),
                       .intrval(iv2$b, iv1,
                                ifelse(substr(type2, 2, 2)=="]", type1, "(]"))
                       | .intrval(iv1$a, iv2,
                                  ifelse(substr(type1, 1, 1)=="[", type2, "[)"))
         )))
}



expect_false(.intrval3(c(4, 5), c(4, 1), "[)", "(]"))

expect_false(.intrval3(c(2, 5), c(1, 2), "()", "()"))

expect_true(.intrval3(c(5, 3), c(4, 5), "[]", "[)"))
expect_true(.intrval3(c(4, 5), c(5, 3), "[)", "[]"))
expect_true(.intrval3(c(3, 5), c(4, 5), "[]", "[)"))

expect_true(.intrval3(c(3, 4), c(3, 4), "(]", "[)"))
expect_true(.intrval3(c(3, 4), c(3, 4), "[)", "(]"))

expect_true(.intrval3(c(1, 3), c(1, 5), "[]", "[]"))

expect_false(.intrval3(c(2, 5), c(2, 1), "[]", "()"))

expect_false(.intrval3(c(4, 4), c(5, 4), "[]", "()"))
expect_false(.intrval3(c(4, 4), c(4, 5), "[]", "()"))

expect_false(.intrval3(c(4, 4), c(4, 5), "[]", "(]"))
expect_false(.intrval3(c(4, 4), c(5, 4), "[]", "[)"))

expect_false(.intrval3(c(2, 4), c(2, 2), "[]", "()"))
expect_false(.intrval3(c(2, 2), c(2, 4), "()", "[]"))

expect_equal( .intrval3(c(2, 4), c(2, 2), "[]", "()"),
              .intrval3(c(2, 2), c(2, 4), "()", "[]") )

