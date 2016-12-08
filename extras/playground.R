## bounding box example

library(intrval)

op <- par(mfrow=c(2,2))
set.seed(1)
n <- 10^4
x <- runif(n, -2, 2)
y <- runif(n, -2, 2)
d <- sqrt(x^2 + y^2)

iv1 <- x %[]% c(-0.25, 0.25) & y %[]% c(-1.5, 1.5)
iv2 <- x %[]% c(-1.5, 1.5) & y %[]% c(-0.25, 0.25)
iv3 <- d %()% c(1, 1.5)

plot(x, y, pch = 19, cex = 0.25, col = iv1 + iv2 + 1,
    main = "Intersecting bounding boxes")
plot(x, y, pch = 19, cex = 0.25, col = iv3 + 1,
     main = "Deck the halls:\ndistance range from center")

## time series filtering

x <- seq(0, 4*24*60*60, 60*60)
dt <- as.POSIXct(x, origin="2000-01-01 00:00:00")
f <- as.POSIXlt(dt)$hour %[]% c(0, 11)

plot(sin(x) ~ dt, type="l", col="grey",
    main = "Filtering date/time objects")
points(sin(x) ~ dt, pch = 19, col = f + 1)

## QCC
library(qcc)
data(pistonrings)
mu <- mean(pistonrings$diameter[pistonrings$trial])
SD <- sd(pistonrings$diameter[pistonrings$trial])
x <- pistonrings$diameter[!pistonrings$trial]
iv <- mu + 3 * c(-SD, SD)
plot(x, pch = 19, col = x %)(% iv +1, type = "b", ylim = mu + 5 * c(-SD, SD),
    main = "Shewhart quality control chart\ndiameter of piston rings")
abline(h = mu)
abline(h = iv, lty = 2)

par(op)

## simulation

set.seed(1)
n <- 100
mu <- 1
x <- rnorm(n, mu, sd = 1)

f <- function(x) {
    m <- lm(x ~ 1)
    c(mean=coef(m), sd=summary(m)$sigma, confint(m, level=0.9)[1,])
}

est <- f(x)

B <- 999
pb <- rbind(est, t(replicate(B, f(rnorm(n, est[1], sd = est[2])))))
z <- mu %[]% pb[,3:4]
table(z) / (B + 1)

sum(mu %[<]% pb[,3:4]) / (B + 1)
sum(mu %[>]% pb[,3:4]) / (B + 1)

## overlap operators

## note that LHS and RHS are not sorted
## interval type1 refers to interval1 and is taken from RHS of 'o' etc
.intrval3 <-
function(interval1, interval2, type1, type2)
{
    iv1 <- .get_intrval(interval1)
    iv2 <- .get_intrval(interval2)

    type1 <- match.arg(type1, c("[]", "[)", "(]", "()"))
    type2 <- match.arg(type2, c("[]", "[)", "(]", "()"))

    if (iv1$a > iv2$a) { # this evaluation is not vectorized!!!
        tmp <- iv1
        iv1 <- iv2
        iv2 <- tmp

        tmp <- type1
        type1 <- type2
        type2 <- tmp
    }

    !.lssthan(iv1$b, iv2,
        ifelse(substr(type1, 2L, 2L)=="]" && substr(type2, 1L, 1L)=="[",
        "[", "("))
}

.get_intrval <- intrval:::.get_intrval
.lssthan <- intrval:::.lssthan

## new specials

"%[]o[]%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="[]", type2="[]")
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
"%()o()%" <- function(interval1, interval2)
    .intrval3(interval1, interval2, type1="()", type2="()")

## here is a test

# n=no overlap
# o=overlap
# u=upper boundary of interval1 (lhs)
# l=upper boundary of interval1 (lhs)
m <- rbind(
    "n"=c(1,2, 3,5),
    "u"=c(1,3, 3,5),
    "o"=c(1,4, 3,5),
    "o"=c(2,4, 3,6),
    "u"=c(2,4, 4,6),
    "n"=c(2,4, 5,6),
    "o"=c(1,5, 2,4),

    "n"=c(3,5, 1,2),
    "l"=c(3,5, 1,3),
    "o"=c(3,5, 1,4),
    "o"=c(3,6, 2,4),
    "l"=c(4,6, 2,4),
    "n"=c(5,6, 2,4),
    "o"=c(2,4, 1,5))

test_fun <- function(type1="[]", type2="[]") {
    val <- sapply(1:nrow(m), function(i)
        .intrval3(m[i,1:2], m[i,3:4], type1, type2))
    expect <- rep(TRUE, length(val))
    expect[rownames(m) == "n"] <- FALSE
    expect[rownames(m) == "u"] <- if (substr(type1, 2L, 2L) == "]" &&
                                      substr(type2, 1L, 1L) == "[")
        TRUE else FALSE
    expect[rownames(m) == "l"] <- if (substr(type1, 1L, 1L) == "[" &&
                                      substr(type2, 2L, 2L) == "]")
        TRUE else FALSE
    rbind(value=val, expect=expect, test=val==expect)
}

tt <- expand.grid(iv1=c("[]", "[)", "(]", "()"), iv2=c("[]", "[)", "(]", "()"))
res <- lapply(1:nrow(tt), function(i)
    test_fun(as.character(tt[i,1]), as.character(tt[i,2])))

sapply(res, function(z) all(z[3,]))

