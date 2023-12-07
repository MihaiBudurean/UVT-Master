ex1 <- function() {
  n <- 600
  p <- 0.3
  batting_avg <- 0.35
  mean_hits <- n * p
  sd_hits <- sqrt(n * p * (1 - p))
  prob_higher <- pnorm(batting_avg, mean = mean_hits, sd = sd_hits, lower.tail = FALSE)
  cat("Probability of batting average higher than 0.350:", prob_higher, "\n")
}

ex2 <- function() {
  n_people <- 15
  mean_weight <- 180
  sd_weight <- 25
  elevator_limit <- 3500
  mean_sum <- n_people * mean_weight
  sd_sum <- sqrt(n_people) * sd_weight
  z_score <- (elevator_limit - mean_sum) / sd_sum
  prob <- pnorm(z_score, lower.tail = FALSE)
  cat("Probability of the elevator carrying more than 3,500 pounds:", prob, "\n")
}

ex3 <- function() {
  probability_1 <- pnorm(2.2)
  cat("1. P(Z ≤ 2.2):", probability_1, "\n")

  probability_2 <- pnorm(2) - pnorm(-1)
  cat("2. P(−1 < Z ≤ 2):", probability_2, "\n")

  probability_3 <- 1 - pnorm(2.5)
  cat("3. P(Z > 2.5):", probability_3, "\n")

  target_probability <- 0.90
  b_value <- qnorm((1 + target_probability) / 2)
  cat("4. b such that P(−b < Z ≤ b) = 0.90:", b_value, "\n")
}

ex4 <- function() {
  par(mfrow = c(1, 1))

  x_values <- seq(-4, 4, length = 1000)

  plot(x_values, dnorm(x_values), type = "l", col = "black", lwd = 2, ylab = "Density", xlab = "x", 
    main = "Standard Normal and t-distributions")

  df_values <- c(5, 10, 25, 50, 100)

  for (df in df_values) {
    lines(x_values, dt(x_values, df), col = rainbow(length(df_values))[df_values == df], lwd = 2, lty = 2)
  }

  legend("topright", legend = c("Standard Normal", 
    paste("t-distribution (df =", df_values, ")", sep = "")), col = c("black", 
    rainbow(length(df_values))), lty = c(1, rep(2, length(df_values))), lwd = 2)
}

ex5 <- function() {
  data(infert)
  data(infert)

  # 1
  # Contingency table for the variables education and spontaneous
  table_education_spontaneous <- table(infert$education, infert$spontaneous)
  print("Contingency table for education and spontaneous:")
  print(table_education_spontaneous)

  # 2
  # Contingency table for the variables education, induced, and spontaneous
  table_education_induced_spontaneous <- table(infert$education, infert$induced, infert$spontaneous)
  print("Contingency table for education, induced, and spontaneous:")
  print(table_education_induced_spontaneous)

  # 3
  # Add marginal frequencies to both crosstabs
  # For education and spontaneous
  table_education_spontaneous_marginal <- addmargins(table_education_spontaneous)
  print("Contingency table with marginal frequencies for education and spontaneous:")
  print(table_education_spontaneous_marginal)

  # Extract marginal frequencies computed on rows
  marginals_education_spontaneous_rows <- margin.table(table_education_spontaneous_marginal, 1)
  print("Marginal frequencies computed on rows for education and spontaneous:")
  print(marginals_education_spontaneous_rows)
}

ex6 <- function() {
  data(iris)

  # 1
  mean_petal_length <- mean(iris$Petal.Length)
  median_petal_length <- median(iris$Petal.Length)
  mode_petal_length <- names(sort(table(iris$Petal.Length), decreasing = TRUE))[1]

  print("Descriptive statistics for Petal.Length:")
  print(paste("Mean:", mean_petal_length))
  print(paste("Median:", median_petal_length))
  print(paste("Mode:", mode_petal_length))

  # 2
  versicolor_data <- subset(iris, Species == "versicolor")
  range_sepal_length <- range(versicolor_data$Sepal.Length)
  variance_sepal_length <- var(versicolor_data$Sepal.Length)
  std_dev_sepal_length <- sd(versicolor_data$Sepal.Length)
  iqr_sepal_length <- IQR(versicolor_data$Sepal.Length)

  print("Descriptive statistics for Sepal.Length in versicolor:")
  print(paste("Range:", paste(range_sepal_length, collapse = " - ")))
  print(paste("Variance:", variance_sepal_length))
  print(paste("Standard Deviation:", std_dev_sepal_length))
  print(paste("IQR:", iqr_sepal_length))

  outliers_sepal_length <- boxplot.stats(versicolor_data$Sepal.Length)$out
  if(length(outliers_sepal_length) > 0) {
    print("Outliers in Sepal.Length for versicolor:")
    print(outliers_sepal_length)
  } else {
    print("No outliers in Sepal.Length for versicolor.")
  }

  # 3
  hist(iris$Petal.Width, main = "Histogram of Petal.Width", xlab = "Petal.Width")
  qqnorm(iris$Petal.Width)
  qqline(iris$Petal.Width, col = 2)

  # 4
  boxplot(Petal.Length ~ Species, data = iris, main = "Boxplot of Petal.Length by Species", xlab = "Species", ylab = "Petal.Length")
}

ex6()