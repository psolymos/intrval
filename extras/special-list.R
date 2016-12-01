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

