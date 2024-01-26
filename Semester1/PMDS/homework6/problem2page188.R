# A total of m white and m black balls are distributed into two urns, with m balls per urn. At
# each step, a ball is randomly selected from each urn and the two balls are interchanged. The
# state of this Markov chain can, thus, be described by the number of black balls in urn 1. Guess
# the invariant measure for this chain and prove that it is reversible.

one_step <- function(state) {
  ball_urn1 <- sample(c(rep("white", state), rep("black", m - state)), size = 1)
  ball_urn2 <- sample(c(rep("white", m - state), rep("black", state)), size = 1)

  new_state <- sum(c(ball_urn1 == "black", ball_urn2 == "black"))

  return(new_state)
}

simulate_chain <- function(initial_state, num_steps) {
  current_state <- initial_state
  states <- numeric(num_steps + 1)
  states[1] <- current_state

  for (i in 1:num_steps) {
    current_state <- one_step(current_state)
    states[i + 1] <- current_state
  }

  return(states)
}

m <- 5
num_steps <- 10000
initial_state <- 3

simulated_states <- simulate_chain(initial_state, num_steps)

hist(simulated_states, breaks = seq(-0.5, m + 0.5, by = 1),
     main = "Simulated Markov Chain",
     xlab = "Number of Black Balls in Urn 1",
     ylab = "Frequency")

invariant_measure <- table(simulated_states) / num_steps
cat("Estimated Invariant Measure:\n", invariant_measure, "\n")

check_reversibility <- function(states) {
  forward_transitions <- table(states[-length(states)], states[-1])
  backward_transitions <- table(states[-1], states[-length(states)])

  all_states <- union(names(forward_transitions), names(backward_transitions))

  forward_transitions <- as.numeric(forward_transitions[all_states])
  backward_transitions <- as.numeric(backward_transitions[all_states])

  return(all(forward_transitions / sum(forward_transitions) == backward_transitions / sum(backward_transitions)))
}

reversibility_check <- check_reversibility(simulated_states)
cat("Reversibility Check:", reversibility_check, "\n")
