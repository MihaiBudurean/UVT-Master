if (!requireNamespace("survival", quietly = TRUE)) {
  install.packages("survival")
}
library(survival)

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
library(dplyr)

library(MASS)

data("cancer")
my_veteran <- veteran %>% 
  mutate(prior = ifelse(prior == 0, FALSE, TRUE)) %>%
  mutate(trt = ifelse(trt == 1, "standard", "test")) %>%
  mutate(status = ifelse(status == 0, FALSE, TRUE))

# Descriptive Analysis
summary(my_veteran)

# trt
my_trt <- table(my_veteran$trt)
barplot(my_trt, ylim = c(0, 70))

# celltype
my_celltype <- table(my_veteran$celltype)
barplot(my_celltype, ylim = c(0, 60))
hist(my_celltype)
pie(my_celltype)

# time
my_time <- table(my_veteran$time)
boxplot(my_time)
plot(density(my_time))
qqnorm(my_time)

# status
my_status <- table(my_veteran$status)
barplot(my_status, ylim = c(0, 130))

# karno
my_karno <- table(my_veteran$karno)
boxplot(my_karno)
plot(density(my_karno))
qqnorm(my_karno)

# diagtime
my_diagtime <- table(my_veteran$diagtime)
boxplot(my_diagtime)
plot(density(my_diagtime))
qqnorm(my_diagtime)

# age
my_age <- table(my_veteran$age)
boxplot(my_age)
plot(density(my_age))
qqnorm(my_age)

# prior
my_prior <- table(prior)
barplot(my_prior)

# Statistic Hypotheses
# Hypothesis 1
treatment <- my_veteran$time[my_veteran$prior == TRUE]
no_treatment <- my_veteran$time[my_veteran$prior == FALSE]


t.test(treatment, no_treatment, mu = 0, alternative = "greater")

# Hypothesis 2
summary(aov(my_veteran$karno ~ my_veteran$celltype))

pairwise.t.test(my_veteran$karno, my_veteran$celltype)

# Predictive Model
karno <- my_veteran$karno
age <- my_veteran$age

model  <- lm(karno ~ age)
residuals <- resid(model)
fitted <- fitted(model)
summary(model)

plot(age, karno)
abline(model)

hist(residuals)
qqnorm(residuals)

shapiro.test(residuals)

x <- (residuals)
y <- (fitted)
plot(y, x)

n_date <- data.frame(age = 68)
predict(model, n_date, interval = "predict", level = 0.95)
