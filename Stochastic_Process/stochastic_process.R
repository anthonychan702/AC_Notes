
library(quantmod)
library(dqrng)
getSymbols('BOc')

train_data = `BOC`['2018']
test_data = `BOC`['2019']


dqRNGkind("pcg64")
dqset.seed(4002)

system.time({
  # Parameters
  t <- 1
  n <- dim(test_data)[1]
  dt <- t / n
  wt <- dqrnorm(n, mean = 0 , sd = 1)
  w = 3
  mu <- mean(tail(train_data$BOC.Adjusted, w))
  sigma <- sd(tail(train_data$BOC.Adjusted, w))
  st <- numeric(n + 1)
  st[1] <- tail(train_data$BOC.Adjusted, 1)
  
  for (i in 1:n) {
    dwt <- rnorm(1, mean = 0, sd = sqrt(dt))  # scaled Brownian increment
    st[i + 1] <- st[i] * exp((mu - 0.5 * sigma^2) * dt +sqrt(sigma) * wt[i])  # GBM update
  }
})

# Plot
time <- seq(0, 252 , by = 1)
plot(time, st, type = "l", col = "blue",
     main = "Simulated Stochastic Process",
     xlab = "Time", ylab = "Process Value (st)")
grid()

