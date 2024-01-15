# Example 1
set.seed(42)
random_variables <- sample(c(-1, 1), 5, replace = TRUE)

cat("Simulated Random Vector:", random_variables, "\n")
cat("-----------------------------------------------------------------\n")

# Example 2
set.seed(42)
sequence <- rnorm(5)

cat("Simulated Sequence of Random Variables:", sequence, "\n")
cat("-----------------------------------------------------------------\n")


# Example 5 1
# a
lambda <- 1
expected_time <- 10 / lambda
cat("Expected time until the tenth immigrant arrives:", expected_time, "days\n")

# b
prob_exceed_two_days <- exp(-2 * lambda)
cat("Probability that the elapsed time exceeds two days:", prob_exceed_two_days, "\n")
cat("-----------------------------------------------------------------\n")

# Example 5 2
simulate_customer_arrivals <- function(lambda, time_period, num_men) {
  total_arrivals <- rpois(1, lambda * time_period)

  gender_arrs <- sample(0:1, total_arrivals, replace = TRUE, prob = c(0.5, 0.5))

  num_women <- total_arrivals - num_men

  return(num_women)
}

lambda <- 100
time_period <- 5
num_men <- 500

num_women_arrivals <- simulate_customer_arrivals(lambda, time_period, num_men)

cat("Expected number of women arrivals in the first 5 hours:", num_women_arrivals, "\n")
cat("-----------------------------------------------------------------\n")


# Example 6
comp_pois_sim <- function(lambda, mean_pass, sd_pass, t) {
  arrivals <- rpois(t, lambda)

  passengers_per_arrival <- rnorm(sum(arrivals), mean_pass, sd_pass)

  cumulative_passengers <- cumsum(passengers_per_arrival)

  return(cumulative_passengers)
}

lambda <- 5
mean_pass <- 100
sd_pass <- 20
sim_time <- 100

# Simulate compound Poisson process
comp_pois_res <- comp_pois_sim(lambda, mean_pass, sd_pass, sim_time)

# Plot the compound Poisson process
time_points <- seq_along(comp_pois_res)
plot(time_points, comp_pois_res, type = "l",
     xlab = "Time", ylab = "Cumulative Number of Passengers",
     main = "Compound Poisson Process Simulation")
