#devtools::install_github("psolymos/intrval")
## examples

## load library
library(intrval)

## run examples with \dontrun sections

help_pages <- c("")

for (i in help_pages) {
    cat("\n\n---------- intrval example:", i, "----------\n\n")
    eval(parse(text=paste0("example('", i,
        "', package = 'intrval', run.dontrun = TRUE)")))
}
