.options_set <- FALSE

.onLoad <- function(libname, pkgname) {
    if (is.null(getOption("intrval_options"))) {
        .options_set <<- TRUE
        options("intrval_options" = list(
            use_fpCompare = TRUE
        ))
    }
    invisible(NULL)
}

.onUnload <- function(libpath) {
    if (.options_set) {
        options("intrval_options" = NULL)
    }
    invisible(NULL)
}

intrval_options <- function(...) {
    opar <- getOption("intrval_options")
    args <- list(...)
    if (length(args)) {
        if (length(args) == 1L && is.list(args[[1L]])) {
            npar <- args[[1L]]
        } else {
            npar <- opar
            npar[match(names(args), names(npar))] <- args
        }
        options("intrval_options" = npar)
    }
    invisible(opar)
}
