intrval_types <- function(type=NULL) {
    tab <- matrix(c(
        "x %[]% c(a, b)", "---x===x---", "x >= a & x <= b",
        "x %[)% c(a, b)", "---x===o---", "x >= a & x <  b",
        "x %(]% c(a, b)", "---o===x---", "x >  a & x <= b",
        "x %()% c(a, b)", "---o===o---", "x >  a & x <  b",

        "x %][% c(a, b)", "===x---x===", "x <= a & x >= b",
        "x %](% c(a, b)", "===x---o===", "x <= a & x >  b",
        "x %)[% c(a, b)", "===o---x===", "x <  a & x >= b",
        "x %)(% c(a, b)", "===o---o===", "x <  a & x >  b"),
        8, 3, byrow=TRUE)
    colnames(tab) <- c("Expression", "Visual", "Meaning")
    rownames(tab) <- substr(tab[,1L], 4, 5)
    if (!is.null(type))
        tab <- tab[type,,drop=FALSE]
    tab
}
