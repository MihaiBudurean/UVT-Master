# 7. ex 1
golden <- function(f, a, b, tol = 0.0000001) {
    ratio <- 2 / (sqrt(5) + 1)
    x1 <- b - ratio * (b - a)
    x2 <- a + ratio * (b - a)

    f1 <- f(x1)
    f2 <- f(x2)

    while(abs(b - a) > tol) {
        if (f2 > f1) {
            b <- x2
            x2 <- x1
            f2 <- f1
            x1 <- b - ratio * (b - a)
            f1 <- f(x1)
        } else {
            a <- x1
            x1 <- x2
            f1 <- f2
            x2 <- a + ratio * (b - a)
            f2 <- f(x2)
        }
    }
    return((a + b) / 2)
}

# a
func1 <- function(x) {
    return (abs(x - 3.5) + abs(x - 2) + abs(x - 1))
}
curve(func1, from = 0, to = 5)
golden(func1, 1, 5)
# b
func2 <- function(x) {
    return (abs(x - 3.2) + abs(x - 3.5) + abs(x - 2) + abs(x -1))
}
curve(func2, from = 0, to = 5)
golden(func2, 1, 5)

# 7.4 ex 1
# a
optimize(func1, interval = c(0, 5))
# b
optimize(func2, interval = c(0, 5))

# 7.4 ex 2
f <- function(params) {
  a <- params[1]
  b <- params[2]
  result <- (a - 1) + 3.2/b + 3 * log(gamma(a)) + 3 * a * log(b)
  return(result)
}

initial_params <- c(a = 1, b = 1)

result_nlm <- nlm(f, p = initial_params)

cat("Results from nlm():\n")
print(result_nlm)

result_optim <- optim(par = initial_params, fn = f)

cat("\nResults from optim():\n")
print(result_optim)
