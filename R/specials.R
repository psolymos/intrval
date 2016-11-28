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
"%[<]%" <- function(x, interval)
    .lssthan(x, interval, "[]")
"%[<)%" <- function(x, interval)
    .lssthan(x, interval, "[)")
"%(<]%" <- function(x, interval)
    .lssthan(x, interval, "(]")
"%(<)%" <- function(x, interval)
    .lssthan(x, interval, "()")

## directional relations for compact intervals: greater than
"%[>]%" <- function(x, interval)
    .greatrthan(x, interval, "[]")
"%[>)%" <- function(x, interval)
    .greatrthan(x, interval, "[)")
"%(>]%" <- function(x, interval)
    .greatrthan(x, interval, "(]")
"%(>)%" <- function(x, interval)
    .greatrthan(x, interval, "()")

## 2 interval overlap
"%[o]%" <- function(interval1, interval2)
    .intrval2(interval1, interval2)

## 2 interval overlap: negation
"%)o(%" <- function(interval1, interval2)
    !.intrval2(interval1, interval2)

## 2 interval, directional: less
"%[<o]%" <- function(interval1, interval2)
    .lssthan2(interval1, interval2)

## 2 interval, directional: greater
"%[o>]%" <- function(interval1, interval2)
    .greatrthan2(interval1, interval2)

## notin
"%notin%" <- function(x, table)
    !(match(x, table, nomatch = 0) > 0)
