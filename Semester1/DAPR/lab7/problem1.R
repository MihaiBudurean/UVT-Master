mean <- 4.03
std_dev <- 0.42
size <- 800
null_hypothesis_mean <- 4.00

t_statistic <- (mean - null_hypothesis_mean) / (std_dev / sqrt(size))

p_value <- 1 - pt(t_statistic, df = size - 1)

print(p_value)