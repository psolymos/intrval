intrval_types <- function(type=NULL) {
    tab <- matrix(c(
        "x %[]%  c(a, b)",  "---x===x---", "x >= a & x <= b",
        "x %)(%  c(a, b)",  "===o---o===", "x < a | x > b",
        "x %[<]% c(a, b)",  "===o---o---", "x < a",
        "x %[>]% c(a, b)",  "---o---o===", "x > b",

        "x %[)%  c(a, b)",  "---x===o---", "x >= a & x < b",
        "x %)[%  c(a, b)",  "===o---x===", "x < a | x >= b",
        "x %[<)% c(a, b)",  "===o---o---", "x < a",
        "x %[>)% c(a, b)",  "---o---x===", "x >= b",

        "x %(]%  c(a, b)",  "---o===x---", "x > a & x <= b",
        "x %](%  c(a, b)",  "===x---o===", "x <= a | x > b",
        "x %(<]% c(a, b)",  "===x---o---", "x <= a",
        "x %(>]% c(a, b)",  "---o---o===", "x > b",

        "x %()%  c(a, b)",  "---o===o---", "x >  a & x < b",
        "x %][%  c(a, b)",  "===x---x===", "x <= a | x >= b",
        "x %(<)% c(a, b)",  "===x---o---", "x <= a",
        "x %(>)% c(a, b)",  "---o---x===", "x >= b"),
        ncol=3, byrow=TRUE)
    colnames(tab) <- c("Expression", "Visual", "Condition")
    rownames(tab) <- substr(tab[,1L], 3, nchar(tab[,1L])-8)
    if (!is.null(type))
        tab <- tab[type,,drop=FALSE]
    tab
}
