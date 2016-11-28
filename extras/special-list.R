tab <- matrix(c(
    "x %[]% c(a, b)", "x >= a & x <= b",
    "x %)(% c(a, b)", "x < a | x > b",
    "x %[<]% c(a, b)", "x < a & x < b",
    "x %[>]% c(a, b)", "x > a & x > b",

    "x %[)% c(a, b)", "x >= a & x < b",
    "x %)[% c(a, b)", "x < a | x >= b",
    "x %[<)% c(a, b)", "x < a & x <= b",
    "x %[>)% c(a, b)", "x > a & x > b",

    "x %(]% c(a, b)", "x > a & x <= b",
    "x %](% c(a, b)", "x <= a | x > b",
    "x %(<]% c(a, b)", "",
    "x %(>]% c(a, b)", "",

    "x %()% c(a, b)", "x > a & x < b",
    "x %][% c(a, b)", "x <= a | x >= b",
    "x %(<)% c(a, b)", "",
    "x %(>)% c(a, b)", "",



    ncol=2, byrow=TRUE)
colnames(tab) <- c("expression", "meaning")
rownames(tab) <- substr(tab[,1L], 3, 6)


