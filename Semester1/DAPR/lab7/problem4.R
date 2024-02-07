pre_test <- c(17, 12, 20, 12, 20, 21, 23, 10, 15, 17, 18, 18)
post_test <- c(19, 25, 18, 18, 26, 19, 27, 14, 20, 22, 16, 18)

t_test_result <- t.test(pre_test, post_test, paired = TRUE)
print(t_test_result)

# I choose the paired test because pre_test score and post_test score 
# are related to the same child
