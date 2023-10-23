# 6.1.1 ex2

d1 <- c(0.1, 0.5, 0.0, 0.4)
d2 <- c(0.2, 0.3, 0.5, 0.0)
d3 <- c(0.3, 0.0, 0.5, 0.2)
d4 <- c(0.2, 0.3, 0.2, 0.3)
P <- rbind(d1, d2, d3, d4)
print(P)

# 6.1.3 ex 1
A <- P
print(A == t(A))
I3 = rbind(c(1, 0, 0), c(0, 1, 0), c(0, 0, 1))
print(I3 == t(I3))

# 6.1.4 ex 1
P1 <- P
P1[lower.tri(P1)] <- 0
print(P1)
