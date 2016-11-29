print_intrval <- function(type=NULL) {
    tab <- intrval_types(type=type)
    print(as.data.frame(tab), print.gap=4, right=FALSE)
    invisible(tab)
}
