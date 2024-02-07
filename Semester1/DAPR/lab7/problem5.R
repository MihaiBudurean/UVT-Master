library(UsingR)
library(MASS)
attach(fat)

model <- lm(body.fat ~ ., data = fat)

f_model <- stepAIC(model, direction = "both")

print(summary(f_model))
print(f_model$anova)

# Adjusted R-squared: 0.9995
# body.fat ~ body.fat.siri + density + weight + BMI + ffweight +
# thigh + knee + bicep + forearm + wrist
