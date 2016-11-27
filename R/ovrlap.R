ovrlap <-
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
    A <- intrval(a, interval2, "[]")
    B <- intrval(b, interval2, "[]")
    A | B
}
