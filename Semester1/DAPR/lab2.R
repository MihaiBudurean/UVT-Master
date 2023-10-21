library(MASS)

# 1.
#i)
data("Cars93")
new_cars93 <- Cars93[,
                     c("Manufacturer", "Make", "Price", "Passengers", "Origin")]
newCars93
# ii)
us_cars <- newCars93[newCars93$Origin == "USA", ]
us_cars
number_of_cars <- nrow(us_cars)
number_of_cars
# iii)
ford_cars <- us_cars[us_cars$Manufacturer == "Ford", ]
ford_cars
# iv)
more_than_5 <- newCars93[newCars93$Passengers >= 5, ]
ordered_more_than_5 <- more_than_5[order(more_than_5$Price), ]
ordered_more_than_5

# 2.
x <- c(1, 4, 2, 6, 8, 9, 11, 10, 21)
indices <- which(seq_along(x) %% 3 == 0)
sum_multiple_of_3 <- sum(x[indices])
sum_multiple_of_3

# 3.
sequence1 <- 2^(1:15)
sequence2 <- (1:15)^3
exceeding_elements <- sequence1[sequence1 > sequence2]
exceeding_elements

# 4.
trial_names <- paste("Trial", 1:10)
trial_names

# 5.
data("mtcars")
mtcars
mtcars$am <- factor(mtcars$am,
                    levels = c(0, 1), labels = c("automatic", "manual"))
number_automatic <- sum(mtcars$am == "automatic")
number_manual <- sum(mtcars$am == "manual")

# 6.
data("USArrests")

# i)
str(USArrests)

# ii)
means <- apply(USArrests, 2, mean)
means

# iii)
exceeds77 <- mean(USArrests$Murder[USArrests$UrbanPop > 77])
under50 <- mean(USArrests$Murder[USArrests$UrbanPop < 50])
exceeds77
under50

# 7.
t <- seq(0, 20, by = 0.01)
x <- sqrt(t) * sin(2 * pi * t)
y <- sqrt(t) * cos(2 * pi * t)
plot(x, y, type = "l", col = "blue", xlab = "X", ylab = "Y",
     main = "Plot of Points", sub = "Points with coordinates (sqrt(t) * sin(2*pi*t), sqrt(t) * cos(2*pi*t))") # nolint: line_length_linter.
