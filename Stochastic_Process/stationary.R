start_date= "2010-01-01"
end_date = "2024-12-31"
getSymbols("USDCAD=X", from = start_date, to = end_date)

data = `USDCAD=X`$`USDCAD=X.Adjusted`
data = log(data) - log(lag(data))
#GARCH
train_data = `data`['2023']$`USDCAD=X.Adjusted`
test_data = `data`['2024']$`USDCAD=X.Adjusted`

garch_m = garch(train_data, order = c(1, 1))

rolling_sd <- rollapply(train_data, width = 3, 
                        FUN = sd, align = "right", fill = NA)
n = length(test_data) + 1
estimated_sd = numeric(n)
estimated_sd[1] = 0.0032413139

for(i in 1:n){
  estimated_sd
}
