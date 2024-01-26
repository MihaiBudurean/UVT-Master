# Each day, your opinion on a particular political issue is either positive, neutral, or negative.
# If it is positive today, then it is neutral or negative tomorrow with equal probability. 
# If it is neutral or negative, it stays the same with probability 0.5, and, otherwise, it is equally likely to
# be either of the other two possibilities. Is this a reversible Markov chain?

# Explanation:
# This is a Markov chain representing daily opinions on a political issue.
#The opinions are classified as "positive", "neutral", or "negative."
# The transition probabilities are as follows:

# - If the opinion is positive today, it will be neutral
# or negative tomorrow with equal probability.

# - If the opinion is neutral or negative today, it has a 50% chance of
# staying the same and a 25% chance of switching to each of
# the other two possibilities.

# This Markov chain is reversible, meaning it satisfies the
# detailed balance condition, which ensures the existence
# of a stationary distribution.

# The detailed balance condition is given by:
# pi(i) P(i, j) = pi(j) P(j, i), where pi(i) is the stationary distribution
# and P(i, j) is the transition probability from state i to state j.

simulate_markov_chain <- function(num_days) {
  states <- character(num_days)
  states[1] <- sample(c("positive", "neutral", "negative"), 1)

  for (day in 2:num_days) {
    current_state <- states[day - 1]

    if (current_state == "positive") {
      next_state <- sample(c("neutral", "negative"), 1)
    } else {
      next_state <- sample(c("positive", "neutral", "negative"), 
                           1, prob = c(0.5, 0.25, 0.25))
    }

    states[day] <- next_state
  }

  return(states)
}

set.seed(123)
result <- simulate_markov_chain(10)

cat("Day\tState\n")
for (day in 1:10) {
  cat(day, "\t", result[day], "\n")
}
