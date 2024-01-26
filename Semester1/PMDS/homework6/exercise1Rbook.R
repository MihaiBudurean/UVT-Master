# Define the circulant matrix P
# a) P is an example of a stochastic matrix. Use the apply()function
# to verify that the row sums add to 1.
cat("a) --------------------------------------\n")
p <- matrix(c(0.1, 0.2, 0.3, 0.4,
              0.4, 0.1, 0.2, 0.3,
              0.3, 0.4, 0.1, 0.2,
              0.2, 0.3, 0.4, 0.1), nrow = 4, byrow = TRUE)

row_sums <- apply(p, 1, sum)
is_stochastic_matrix <- all(abs(row_sums - 1) < 1e-10)

if (is_stochastic_matrix) {
  cat("The matrix P is a stochastic matrix. Row sums add up to 1.\n")
} else {
  cat("The matrix P is not a stochastic matrix. Row sums do not add up to 1.\n")
}

# b) Compute P^n for n = 2, 3, 5, 10. Is a pattern emerging?
n_values <- c(2, 3, 5, 10)
cat("b) --------------------------------------\n")

for (n in n_values) {
  p_n <- p
  for (i in 2:n) {
    p_n <- p_n %*% p
  }
  cat("P ^", n, ":\n")
  print(p_n)
  cat("\n")
}
# c) Find a nonnegative vector x whose elements sum to 1 and which satisfies
# (I - P^T)x = 0. Do you see any connection between P^10 and x?
cat("c) --------------------------------------\n")
i <- diag(4)
x <- solve(t(i - t(p)), rep(0, 4))
x <- x / sum(x)
cat("Stationary distribution vector x:\n")
print(x)

cat("d) --------------------------------------\n")
n <- 15
y <- numeric(n)
y[1] <- 1

for (j in 2:n) {
  y[j] <- sample(1:4, 1, prob = p[y[j - 1], ])
}

cat("Generated pseudorandom sequence:\n")
print(y)

# e) Use the table()function to determine the relative frequency
# distribution of the four possible values in the y vector. Compare
# this distribution with the stationary distribution x calculated earlier.
cat("e) --------------------------------------\n")
# relative_frequency_y <- table(y) / length(y)

# cat("\nRelative frequency distribution of y:\n")
# print(relative_frequency_y)

# cat("\nComparison with stationary distribution x:\n")
# print(cbind(Stationary_Distribution = x, 
#       Relative_Frequency_Y = relative_frequency_y))
