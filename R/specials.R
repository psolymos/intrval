## compact interval relations
"%[]%" <- function(x, interval)
    .intrval(x, interval, "[]")
"%[)%" <- function(x, interval)
    .intrval(x, interval, "[)")
"%(]%" <- function(x, interval)
    .intrval(x, interval, "(]")
"%()%" <- function(x, interval)
    .intrval(x, interval, "()")

## disjoint interval relations
"%][%" <- function(x, interval)
    !.intrval(x, interval, "()")
"%](%" <- function(x, interval)
    !.intrval(x, interval, "(]")
"%)[%" <- function(x, interval)
    !.intrval(x, interval, "[)")
"%)(%" <- function(x, interval)
    !.intrval(x, interval, "[]")

## directional relations for compact intervals: less than
"%[<]%" <- function(x, interval)
    .lessthan(x, interval, "[]")
"%[<)%" <- function(x, interval)
    .lessthan(x, interval, "[)")
"%(<]%" <- function(x, interval)
    .lessthan(x, interval, "(]")
"%(<)%" <- function(x, interval)
    .lessthan(x, interval, "()")

## directional relations for compact intervals: greater than
"%[>]%" <- function(x, interval)
    !.intrval(x, interval, "[]") & !.lessthan(x, interval, "[]")
"%[>)%" <- function(x, interval)
    !.intrval(x, interval, "[)") & !.lessthan(x, interval, "[)")
"%(>]%" <- function(x, interval)
    !.intrval(x, interval, "(]") & !.lessthan(x, interval, "(]")
"%(>)%" <- function(x, interval)
    !.intrval(x, interval, "()") & !.lessthan(x, interval, "()")

## 2 interval overlap
"%[o]%" <- function(interval1, interval2)
    .ovrlap(interval1, interval2)

## notin
"%notin%" <- function(x, table)
    !(match(x, table, nomatch = 0) > 0)
