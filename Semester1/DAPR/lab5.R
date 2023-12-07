ex9_2 <- function() {
  library(UsingR)
  attach(samhda)
  x <- length(marijuana[marijuana == 1])
  n <- length(marijuana)
  print(binom.test(x, n, alternative = "less"))
}

ex9_7 <- function() {
  print(binom.test(2700, 25000, alternative = "greater"))
}

ex9_8 <- function() {
  return
}

ex9_14 <- function() {
  return
}

ex9_25 <- function() {
  return
}

ex9_30 <- function() {
  return
}

ex9_32 <- function() {
  return
}

ex9_2()
ex9_7()
