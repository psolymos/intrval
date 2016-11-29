.get_intrval <-
function(interval, sort=TRUE)
{
    if (sort) {
        if (!is.null(dim(interval))) {
            a <- pmin(interval[,1L], interval[,2L], na.rm=FALSE)
            b <- pmax(interval[,1L], interval[,2L], na.rm=FALSE)
        } else {
            if (is.list(interval)) {
                a <- pmin(interval[[1L]], interval[[2L]], na.rm=FALSE)
                b <- pmax(interval[[1L]], interval[[2L]], na.rm=FALSE)
            } else {
                a <- pmin(interval[1L], interval[2L], na.rm=TRUE)
                b <- pmax(interval[1L], interval[2L], na.rm=TRUE)
            }
        }
    } else {
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
    ab <- .get_intrval(interval, sort=TRUE)
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
    ab <- .get_intrval(interval, sort=TRUE)
    A <- switch(type_a,
        "[" = x < ab$a,
        "(" = x <= ab$a)
#    B <- switch(type_b,
#        "]" = x <= ab$b,
#        ")" = x < ab$b)
#    A & B
    A
}

.greatrthan <-
function(x, interval, type)
{
    type <- match.arg(type,
        c("[]", "[)", "(]", "()"))
    type_a <- substr(type, 1L, 1L)
    type_b <- substr(type, 2L, 2L)
    ab <- .get_intrval(interval, sort=TRUE)
#    A <- switch(type_a,
#        "[" = x > ab$a,
#        "(" = x >= ab$a)
    B <- switch(type_b,
        "]" = x > ab$b,
        ")" = x >= ab$b)
#    A & B
    B
}

## a1 %[]% c(a2, b2) | b1 %[]% c(a2, b2)
.intrval2 <-
function(interval1, interval2)
{
    ab <- .get_intrval(interval1, sort=TRUE)
    A <- .intrval(ab$a, interval2, "[]")
    B <- .intrval(ab$b, interval2, "[]")
    A | B
}

## b1 < a2
.lssthan2 <-
function(interval1, interval2)
{
    ab <- .get_intrval(interval1, sort=TRUE)
#    A <- .lssthan(ab$a, interval2, "[]")
    B <- .lssthan(ab$b, interval2, "[]")
#    A & B
    B
}

## a1 > b2
.greatrthan2 <-
function(interval1, interval2)
{
    ab <- .get_intrval(interval1, sort=TRUE)
    A <- .greatrthan(ab$a, interval2, "[]")
#    B <- .greatrthan(ab$b, interval2, "[]")
#    A & B
    A
}
