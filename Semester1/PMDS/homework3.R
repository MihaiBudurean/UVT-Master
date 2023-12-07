# ex 1 ch 5.2
generate_pseudorandom_numbers1 <- function(n, seed) {
  x <- seed
  result <- numeric(n)

  for (i in 1:n) {
    x <- (172 * x) %% 30307
    result[i] <- x
  }

  return(result)
}

seed <- 17218
pseudorandom_numbers <- generate_pseudorandom_numbers1(20, seed)
print(pseudorandom_numbers)

# ex 2 ch 5


# Function to generate pseudorandom numbers
generate_pseudorandom_numbers <- function(n, a, c, m, seed) {
  x <- seed
  result <- numeric(n)

  for (i in 1:n) {
    x <- (a * x + c) %% m
    result[i] <- x
  }

  return(result)
}

a <- 171
c <- 0
m <- 32767
seed <- 2018
pseudorandom_numbers <- generate_pseudorandom_numbers(20, a, c, m, seed)
print(pseudorandom_numbers)
