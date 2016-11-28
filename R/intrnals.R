.sort_intrval <-
function(interval)
{
    if (!is.null(dim(interval))) {
        a <- pmin(interval[,1L], interval[,2L], na.rm=TRUE)
        b <- pmax(interval[,1L], interval[,2L], na.rm=TRUE)
    } else {
        if (is.list(interval)) {
            a <- pmin(interval[[1L]], interval[[2L]], na.rm=TRUE)
            b <- pmax(interval[[1L]], interval[[2L]], na.rm=TRUE)
        } else {
            a <- pmin(interval[1L], interval[2L], na.rm=TRUE)
            b <- pmax(interval[1L], interval[2L], na.rm=TRUE)
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
    ab <- .sort_intrval(interval)
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
    type <- match.arg(type,
        c("[]", "[)", "(]", "()"))
    type_a <- substr(type, 1L, 1L)
    type_b <- substr(type, 2L, 2L)
    ab <- .sort_intrval(interval)
    A <- switch(type_a,
        "[" = x < ab$a,
        "(" = x <= ab$a)
    B <- switch(type_b,
        "]" = x <= ab$b,
        ")" = x < ab$b)
    A & B
}

.greatrthan <-
function(x, interval, type)
{
    !.intrval(x, interval, "()") & !.lssthan(x, interval, "()")
}

.intrval2 <-
function(interval1, interval2)
{
    ab <- .sort_intrval(interval1)
    A <- .intrval(ab$a, interval2, "[]")
    B <- .intrval(ab$b, interval2, "[]")
    A | B
}

.lssthan2 <-
function(interval1, interval2)
{
    ab <- .sort_intrval(interval1)
    A <- .intrval(ab$a, interval2, "[]")
    B <- .intrval(ab$b, interval2, "[]")
    A & B
}

.greatrthan2 <-
function(interval1, interval2)
{
    !.intrval2(interval1, interval2) & !.lssthan2(interval1, interval2)
}
