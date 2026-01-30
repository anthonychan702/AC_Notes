# ito process is define by dxt = mu*dt + simga*dwt

# Here is general ito process Monlo Carlo 
# xt ~ lognormal( ln(x0)+ (alpha-beta^2/2)t , beta^2*t)

# example consider xt is portfolio of w*St + (1-w)*bt
# Assume a = w*mu + (1-w)r 
# w = (mu-r)/sigma^2
load("Data/hsi_stock_data.RData")
r = 0.02
train_data = as.data.frame.list(completed_hsi_stock_datalist['3988.HK'])

wt = rnorm(1 , 0 ,1)
z = rnorm(1, a

          
          
          