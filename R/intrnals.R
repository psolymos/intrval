.intrval <-
function(x, interval, type)
{
    type <- match.arg(type,
        c("[]", "[)", "(]", "()", "][", "](", ")[", ")("))
    type_a <- substr(type, 1L, 1L)
    type_b <- substr(type, 2L, 2L)
    if (!is.null(dim(interval))) {
        a <- interval[,1L]
        b <- interval[,2L]
    } else {
        if (is.list(interval)) {
            a <- interval[[1L]]
            b <- interval[[2L]]
        } else {
            a <- interval[1L]
            b <- interval[2L]
        }
    }
    A <- switch(type_a,
        "[" = x >= a,
        "]" = x <= a,
        "(" = x > a,
        ")" = x < a)
    B <- switch(type_b,
        "[" = x >= b,
        "]" = x <= b,
        "(" = x > b,
        ")" = x < b)
    A & B
}

.lssthan <-
function(x, interval, type)
{
    type <- match.arg(type,
        c("[]", "[)", "(]", "()"))
    type_a <- substr(type, 1L, 1L)
    type_b <- substr(type, 2L, 2L)
    if (!is.null(dim(interval))) {
        a <- interval[,1L]
        b <- interval[,2L]
    } else {
        if (is.list(interval)) {
            a <- interval[[1L]]
            b <- interval[[2L]]
        } else {
            a <- interval[1L]
            b <- interval[2L]
        }
    }
    A <- switch(type_a,
        "[" = x < a,
        "(" = x <= a)
    B <- switch(type_b,
        "]" = x <= b,
        ")" = x < b)
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
    if (!is.null(dim(interval1))) {
        a <- interval1[,1L]
        b <- interval1[,2L]
    } else {
        if (is.list(interval1)) {
            a <- interval1[[1L]]
            b <- interval1[[2L]]
        } else {
            a <- interval1[1L]
            b <- interval1[2L]
        }
    }
    A <- .intrval(a, interval2, "[]")
    B <- .intrval(b, interval2, "[]")
    A | B
}

.lssthan2 <-
function(interval1, interval2)
{
    if (!is.null(dim(interval1))) {
        a <- interval1[,1L]
        b <- interval1[,2L]
    } else {
        if (is.list(interval1)) {
            a <- interval1[[1L]]
            b <- interval1[[2L]]
        } else {
            a <- interval1[1L]
            b <- interval1[2L]
        }
    }
    A <- .lssthan(a, interval2, "[]")
    B <- .lssthan(b, interval2, "[]")
    A & B
}

.greatrthan2 <-
function(interval1, interval2)
{
    !.intrval2(interval1, interval2) & !.lssthan2(interval1, interval2)
}
