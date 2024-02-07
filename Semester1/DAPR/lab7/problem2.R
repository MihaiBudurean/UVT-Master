library(UsingR)
data(babies)

# Point a)
print("a) ")
gestation_smoker <- babies$gestation[babies$smoke > 0]
gestation_nonsmoker <- babies$gestation[babies$smoke == 0]

result <- t.test(gestation_smoker, gestation_nonsmoker, conf.level = 0.95)

print("Results\n")
print(result)

# Point b)
print("b) ")
ages_mother <- babies$age
ages_father <- babies$dage

paired_result <- t.test(ages_mother, ages_father, paired = TRUE)

print("\nResults:\n")
print(paired_result)