library(zoo)
library(quantmod)
library(dplyr)

load('hsi_stock_data.RData')

log_return_list = list()
for (stock_name in names(completed_hsi_stock_datalist)) {
  stock_data <- completed_hsi_stock_datalist[[stock_name]]
  
  log_ret <- diff(log(stock_data[,6]))
  
  log_return_list[[stock_name]] <- log_ret
}

log_return_xts = do.call(merge, log_return_list)

rm(log_ret,log_return_list,stock,stock_data , stock_name)
