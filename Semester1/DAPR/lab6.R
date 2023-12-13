setwd("/home/mihai/UVT-Master/Semester1/DAPR")

ex1 <- function() {
  data <- read.table("./poverty.txt", sep = "\t", header = TRUE)

  plot(data$PovPct, data$Brth15to17,
      main = "Scatter Plot of Poverty Rate vs Birth Rate",
      xlab = "Poverty Rate (%)", ylab = "Birth Rate (per 1000 females)")

  correlation_coefficient <- cor(data$PovPct, data$Brth15to17)
  cat("Correlation Coefficient:", correlation_coefficient, "\n")

  linear_model <- lm(Brth15to17 ~ PovPct, data = data)

  abline(linear_model, col = "red")

  summary(linear_model)

  predicted_birth_rate <- predict(linear_model, 
    newdata = data.frame(PovPct = 12.7))
  cat("Predicted Birth Rate for Poverty Rate 12.7%:", 
    predicted_birth_rate, "\n")
}

ex2 <- function() {
  attach(mtcars)
  data <- mtcars[, c("mpg", "disp", "hp", "wt")]

  correlation_matrix <- cor(data)
  print("Correlation Coefficient Matrix:")
  print(correlation_matrix)

  linear_model <- lm(mpg ~ disp + hp + wt, data = data)
  print(linear_model)
  summary(linear_model)
}

ex3 <- function() {
  install.packages("glmnet")
  library(glmnet)
  data <- read.csv("binary.csv")
  str(data)
  head(data)
  model <- glm(admit ~ gre + gpa + rank, data = data, family = "binomial")
  summary(model)
}

ex3()