intrval_types <- function(type=NULL, plot=FALSE) {
    tab <- matrix(c(
        "x %[]% c(a, b)",  "---x===x---", "x >= a & x <= b",
        "x %)(% c(a, b)",  "===o---o===", "x < a | x > b",
        "x %[<]% c(a, b)",  "===o---o---", "x < a",
        "x %[>]% c(a, b)",  "---o---o===", "x > b",

        "x %[)% c(a, b)",  "---x===o---", "x >= a & x < b",
        "x %)[% c(a, b)",  "===o---x===", "x < a | x >= b",
        "x %[<)% c(a, b)",  "===o---o---", "x < a",
        "x %[>)% c(a, b)",  "---o---x===", "x >= b",

        "x %(]% c(a, b)",  "---o===x---", "x > a & x <= b",
        "x %](% c(a, b)",  "===x---o===", "x <= a | x > b",
        "x %(<]% c(a, b)",  "===x---o---", "x <= a",
        "x %(>]% c(a, b)",  "---o---o===", "x > b",

        "x %()% c(a, b)",  "---o===o---", "x > a & x < b",
        "x %][% c(a, b)",  "===x---x===", "x <= a | x >= b",
        "x %(<)% c(a, b)",  "===x---o---", "x <= a",
        "x %(>)% c(a, b)",  "---o---x===", "x >= b"),
        ncol=3, byrow=TRUE)
    colnames(tab) <- c("Expression", "Visual", "Condition")
    rownames(tab) <- substr(tab[,1L], 3, nchar(tab[,1L])-8)
    if (!is.null(type)) {
        if (length(type) < 1L)
            stop("type must be NULL or has positive length")
        if (is.character(type))
            type <- match.arg(type, rownames(tab), several.ok=TRUE)
        tab <- tab[type,,drop=FALSE]
    }
    if (plot) {
        col_open <- "grey"
        col_closed <- "black"
        n <- nrow(tab)
        op <- par(mar=c(1,1,1,1), family="mono")
        on.exit(par(op))
        plot(0, type="n", ylim=c(n+2, -1), xlim=c(1,8), axes=FALSE, ann=FALSE)
        text(c(2, 4.5, 7), c(-1,-1,-1), colnames(tab))
        text(c(4,5), c(n+1,n+1), c("a","b"))
        text(7, n+2, c("(a <= b)"))
        text(rep(2, n), seq_len(n), tab[,1])
        text(rep(7, n), seq_len(n), tab[,3])
        for (i in seq_len(n)) {
            lines(c(3, 6), c(i,i), lwd=3, col=col_open)
            if (substr(tab[,2], 1, 1)[i] == "=")
                lines(c(3,4), c(i,i), lwd=3, col=col_closed)
            if (substr(tab[,2], 5, 5)[i] == "=")
                lines(c(4,5), c(i,i), lwd=3, col=col_closed)
            if (substr(tab[,2], 9, 9)[i] == "=")
                lines(c(5,6), c(i,i), lwd=3, col=col_closed)
            points(c(4, 5), c(i,i), cex=1.5, col=col_open, pch=19)
            points(c(4, 5), c(i,i), cex=1.5, col=1, pch=21)
            if (substr(tab[,2], 4, 4)[i] == "x")
                points(4, i, cex=1.5, pch=19, col=col_closed)
            if (substr(tab[,2], 8, 8)[i] == "x")
                points(5, i, cex=1.5, pch=19, col=col_closed)
        }

    } else {
        print(as.data.frame(tab), print.gap=4, right=FALSE)
    }
    invisible(tab)
}
