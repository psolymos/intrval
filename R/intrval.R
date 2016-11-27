intrval <-
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
