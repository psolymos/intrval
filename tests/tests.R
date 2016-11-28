#devtools::install_github("psolymos/intrval")
## examples

## load library
library(intrval)

## run examples with \dontrun sections

help_pages <- c("%[]%", "%!in%")

for (i in help_pages) {
    cat("\n\n---------- intrval example:", i, "----------\n\n")
    eval(parse(text=paste0("example('", i,
        "', package = 'intrval', run.dontrun = TRUE)")))
}

## testing

test_fun <- function(xchr, abchr, printout=TRUE, expect_NA=FALSE) {
    tab <- intrval_types(type=NULL)
    ex <- tab[,3]
    hit <- cbind(
        substr(tab[,2], 1, 1) == "=",
        substr(tab[,2], 4, 4) == "x",
        substr(tab[,2], 5, 5) == "=",
        substr(tab[,2], 8, 8) == "x",
        substr(tab[,2], 9, 9) == "=")
    for (i in seq_len(nrow(tab))) {
        xpt <- hit[i,]
        got <- eval(parse(text=
            paste0("(", xchr, ") %", names(ex)[i], "% (", abchr, ")")
        ))
        if (printout) {
            cat("\n", rownames(tab)[i], "\n")
            mat <- rbind(Expect=xpt, Got=got)
            print(mat)
        }
        allOK <- if (expect_NA)
            all(is.na(got)) else all(xpt == got)
        stopifnot(allOK)
    }
    invisible(NULL)
}

## integer
test_fun("1L:5L", "c(2L,4L)")
## numeric
test_fun("(1:5)+0.5", "c(2,4)+0.5")
## character
test_fun("c('a','b','c','d','e')", "c('b','d')")
## ordered
test_fun("as.ordered(c('a','b','c','d','e'))", "c('b','d')")
## factor -- leads to NA
suppressWarnings(test_fun("as.factor(c('a','b','c','d','e'))", "c('b','d')",
    expect_NA=TRUE))
## date
test_fun("as.Date(1:5,origin='2000-01-01')", "as.Date(c(2,4),origin='2000-01-01')")
