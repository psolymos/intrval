.get_intrval <-
function(interval)
{
    if (!is.null(dim(interval))) {
        if (ncol(interval) > 2L)
            warning("only first 2 columns of interval object are used")
        a <- pmin(interval[,1L], interval[,2L], na.rm=FALSE)
        b <- pmax(interval[,1L], interval[,2L], na.rm=FALSE)
    } else {
        if (length(interval) > 2L)
            warning("only first 2 elements of interval object are used")
        if (is.list(interval)) {
            a <- pmin(interval[[1L]], interval[[2L]], na.rm=FALSE)
            b <- pmax(interval[[1L]], interval[[2L]], na.rm=FALSE)
        } else {
            a <- pmin(interval[1L], interval[2L], na.rm=FALSE)
            b <- pmax(interval[1L], interval[2L], na.rm=FALSE)
        }
    }
    list(a=a, b=b)
}

.intrval <-
function(x, interval, type)
{
    type <- match.arg(type,
        c("[]", "[)", "(]", "()", "][", "](", ")[", ")("))
    type_a <- substr(type, 1L, 1L)
    type_b <- substr(type, 2L, 2L)
    ab <- .get_intrval(interval)
    A <- switch(type_a,
        "[" = x >= ab$a,
        "]" = x <= ab$a,
        "(" = x > ab$a,
        ")" = x < ab$a)
    B <- switch(type_b,
        "[" = x >= ab$b,
        "]" = x <= ab$b,
        "(" = x > ab$b,
        ")" = x < ab$b)
    A & B
}

.lssthan <-
function(x, interval, type)
{
    ab <- .get_intrval(interval)
    switch(match.arg(type, c("[", "(")),
        "[" = x < ab$a,
        "(" = x <= ab$a)
}

.greatrthan <-
function(x, interval, type)
{
    ab <- .get_intrval(interval)
    switch(match.arg(type, c("]", ")")),
        "]" = x > ab$b,
        ")" = x >= ab$b)
}

## a1 %[]% c(a2, b2) | b1 %[]% c(a2, b2)
.intrval2 <-
function(interval1, interval2, overlap=TRUE)
{
    ab <- .get_intrval(interval1)
    A <- .greatrthan(ab$a, interval2, "]")
    B <- .lssthan(ab$b, interval2, "[")
    if (overlap)
        !(A | B) else (A | B)
}

## b1 < a2
.lssthan2 <-
function(interval1, interval2)
{
    ab <- .get_intrval(interval1)
    .lssthan(ab$b, interval2, "[")
}

## a1 > b2
.greatrthan2 <-
function(interval1, interval2)
{
    ab <- .get_intrval(interval1)
    .greatrthan(ab$a, interval2, "]")
}

## this function can be used for general 2-interval comparisons
.intrval3 <-
function(interval1, interval2, type1, type2)
{
    iv1 <- .get_intrval(interval1)
    iv2 <- .get_intrval(interval2)

    type1 <- match.arg(type1, c("[]", "[)", "(]", "()"))
    type2 <- match.arg(type2, c("[]", "[)", "(]", "()"))

    b1 <- ifelse(iv1$a < iv2$a, iv1$b, iv2$b)
    a2 <- ifelse(iv1$a < iv2$a, iv2$a, iv1$a)
    type1v <- ifelse(iv1$a < iv2$a, substr(type1, 2L, 2L), substr(type2, 2L, 2L))
    type2v <- ifelse(iv1$a < iv2$a, substr(type2, 1L, 1L), substr(type1, 1L, 1L))

    ifelse(type1v == "]" & type2v == "[",
        b1 >= a2,
        b1 > a2)
}

