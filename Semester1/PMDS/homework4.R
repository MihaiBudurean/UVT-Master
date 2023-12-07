# ex 3 ch 5.3.1
simulate_light_bulbs <- function(num_bulbs, probability) {
  bulb_states <- rbinom(num_bulbs, 1, probability)

  mean_value <- mean(bulb_states)
  variance_value <- var(bulb_states)

  return(list(mean = mean_value, variance = variance_value, simulated_states = bulb_states))
}

num_bulbs <- 500
probability_working <- 0.99

simulation_result <- simulate_light_bulbs(num_bulbs, probability_working)

cat("Simulated Mean:", simulation_result$mean, "\n")
cat("Simulated Variance:", simulation_result$variance, "\n")

theoretical_mean <- probability_working
theoretical_variance <- probability_working * (1 - probability_working)

cat("Theoretical Mean:", theoretical_mean, "\n")
cat("Theoretical Variance:", theoretical_variance, "\n\n\n")

# ex 3 ch 5.3.2
n <- 18
p <- 0.76
num_simulations <- 10000

simulated_values <- rbinom(num_simulations, n, p)

simulated_mean <- mean(simulated_values)
simulated_variance <- var(simulated_values)

theoretical_mean <- n * p
theoretical_variance <- n * p * (1 - p)

cat("Simulated Mean:", simulated_mean, "\n")
cat("Simulated Variance:", simulated_variance, "\n")

cat("Theoretical Mean:", theoretical_mean, "\n")
cat("Theoretical Variance:", theoretical_variance, "\n")

