library(MASS)
data(quine)

women_a <- quine$Days[quine$Sex == "F" & quine$Eth == "A"]
women_n <- quine$Days[quine$Sex == "F" & quine$Eth == "N"]

observed_table <- matrix(c(sum(women_a > 0), sum(women_n > 0),
                           length(women_a) - sum(women_a > 0),
                           length(women_n) - sum(women_n > 0)),
                         nrow = 2, byrow = TRUE)

prop_test <- prop.test(observed_table)
print(prop_test)