library(UsingR)
library(MASS)

data(hall.fame)

model <- glm(Hall.Fame.Membership ~ BA + HR + hits + games, data = hall.fame, family = binomial)

f_model <- stepAIC(model, direction = "both")

print(f_model$anova)

# Final Model:
# Hall.Fame.Membership ~ BA + HR + hits
