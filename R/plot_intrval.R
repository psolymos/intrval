plot_intrval <-
function(type=NULL)
{
    col_open <- "grey"
    col_closed <- "black"
    tab <- intrval_types(type=type)
    n <- nrow(tab)
    op <- par(mar=c(1,1,1,1))
    plot(0, type="n", ylim=c(n+1, -1), xlim=c(1,8), axes=FALSE, ann=FALSE)
    text(rep(2, n), seq_len(n), tab[,1])
    text(rep(7, n), seq_len(n), tab[,3])
    text(c(2, 4.5, 7), c(-1,-1,-1), colnames(tab))
    text(c(4,5), c(n+1,n+1), c("a","b"))
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
    par(op)
    invisible(tab)
}

intrval_types <- function(type=NULL) {
    tab <- matrix(c(
        "%[]%", "---x===x---", "x >= a & x <= b",
        "%[)%", "---x===o---", "x >= a & x <  b",
        "%(]%", "---o===x---", "x >  a & x <= b",
        "%()%", "---o===o---", "x >  a & x <  b",

        "%][%", "===x---x===", "x <= a & x >= b",
        "%](%", "===x---o===", "x <= a & x >  b",
        "%)[%", "===o---x===", "x <  a & x >= b",
        "%)(%", "===o---o===", "x <  a & x >  b"),
        8, 3, byrow=TRUE)
    colnames(tab) <- c("Operator", "Visual", "Meaning")
    rownames(tab) <- substr(tab[,1L], 2, 3)
    if (!is.null(type))
        tab <- tab[type,,drop=FALSE]
    tab
}

print_intrval <- function(type=NULL) {
    tab <- intrval_types(type=type)
    print(as.data.frame(tab), print.gap=4)
    invisible(tab)
}
