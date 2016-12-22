## compact interval relations
"%[]%" <- function(x, interval)
    .intrval(x, interval, "[]")
"%[)%" <- function(x, interval)
    .intrval(x, interval, "[)")
"%(]%" <- function(x, interval)
    .intrval(x, interval, "(]")
"%()%" <- function(x, interval)
    .intrval(x, interval, "()")

## disjoint interval relations: negation
"%)(%" <- function(x, interval)
    !.intrval(x, interval, "[]")
"%)[%" <- function(x, interval)
    !.intrval(x, interval, "[)")
"%](%" <- function(x, interval)
    !.intrval(x, interval, "(]")
"%][%" <- function(x, interval)
    !.intrval(x, interval, "()")

## directional relations for compact intervals: less than
#"%<[%" <- function(x, interval) # <
#    .lssthan(x, interval, "[")
#"%<(%" <- function(x, interval) # <=
#    .lssthan(x, interval, "(")
"%[<]%" <- function(x, interval)
    .lssthan(x, interval, "[")
"%[<)%" <- function(x, interval)
    .lssthan(x, interval, "[")
"%(<]%" <- function(x, interval)
    .lssthan(x, interval, "(")
"%(<)%" <- function(x, interval)
    .lssthan(x, interval, "(")

## directional relations for compact intervals: greater than
#"%]>%" <- function(x, interval) # >
#    .greatrthan(x, interval, "]")
#"%)>%" <- function(x, interval) # >=
#    .greatrthan(x, interval, ")")
"%[>]%" <- function(x, interval)
    .greatrthan(x, interval, "]")
"%[>)%" <- function(x, interval)
    .greatrthan(x, interval, ")")
"%(>]%" <- function(x, interval)
    .greatrthan(x, interval, "]")
"%(>)%" <- function(x, interval)
    .greatrthan(x, interval, ")")

## notin/nin/ni - opposite of %in%
"%ni%" <- function(x, table)
    !(match(x, table, nomatch = 0) > 0)

## 2 closed intervals
"%[o]%" <- function(interval1, interval2)
    .intrval2(interval1, interval2, overlap=TRUE, closed=TRUE)
## 2 interval overlap: negation
"%)o(%" <- function(interval1, interval2)
    .intrval2(interval1, interval2, overlap=FALSE, closed=TRUE)
## 2 interval, directional: less
"%[<o]%" <- function(interval1, interval2)
    .lssthan2(interval1, interval2, closed=TRUE)
## 2 interval, directional: greater
"%[o>]%" <- function(interval1, interval2)
    .greatrthan2(interval1, interval2, closed=TRUE)

## 2 open intervals
"%(o)%" <- function(interval1, interval2)
    .intrval2(interval1, interval2, overlap=TRUE, closed=FALSE)
## 2 interval overlap: negation
"%]o[%" <- function(interval1, interval2)
    .intrval2(interval1, interval2, overlap=FALSE, closed=FALSE)
## 2 interval, directional: less
"%(<o)%" <- function(interval1, interval2)
    .lssthan2(interval1, interval2, closed=FALSE)
## 2 interval, directional: greater
"%(o>)%" <- function(interval1, interval2)
    .greatrthan2(interval1, interval2, closed=FALSE)

## specific 2 interval overlap operators

## this is alias for %[o]% but less efficient
#"%[]o[]%" <- function(interval1, interval2)
#    .intrval3(interval1, interval2, type1="[]", type2="[]")
## this is 10x faster
"%[]o[]%" <- function(interval1, interval2)
    interval1 %[o]% interval2
"%[]o[)%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[]", type2="[)")
"%[]o(]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[]", type2="(]")
"%[]o()%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[]", type2="()")

"%[)o[]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[)", type2="[]")
"%[)o[)%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[)", type2="[)")
"%[)o(]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[)", type2="(]")
"%[)o()%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[)", type2="()")

"%(]o[]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="(]", type2="[]")
"%(]o[)%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="(]", type2="[)")
"%(]o(]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="(]", type2="(]")
"%(]o()%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="(]", type2="()")

"%()o[]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="()", type2="[]")
"%()o[)%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="()", type2="[)")
"%()o(]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="()", type2="(]")
## this is alias for %(o)% but less efficient
#"%()o()%" <- function(interval1, interval2)
#    .intrval3(interval1, interval2, type1="()", type2="()")
## this is 10x faster
"%()o()%" <- function(interval1, interval2)
    interval1 %(o)% interval2
