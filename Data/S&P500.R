library(zoo)
library(quantmod)
library(dplyr)
# start at 2019-01 Until 2025-12

SP500_datalist = list()
start = '2019-01-01'
end = '2025-12-31'

SP500_close = read.csv("C:/Users/antho/文件/RMSC_R/Investmnet/Data/us_stocks.csv")

SP500_stocks_list = read.csv("C:/Users/antho/文件/RMSC_R/Investmnet/Data/constituents.csv")

SP500_symbols = SP500_stocks_list[,1]
# Because '.' cannot contain in symbols under yahoo finance standard , so we have to change

for (symbol in SP500_symbols) {
  yahoo_symbol <- gsub("\\.", "-", symbol)
  
  cat("Downloading:", yahoo_symbol, "\n")
  
  stock_data <- tryCatch({
    getSymbols(yahoo_symbol, from = start, to = end, auto.assign = FALSE)
  }, error = function(e) {
    cat("Failed to download:", yahoo_symbol, "\n")
    return(NULL)
  })
  
  if (!is.null(stock_data)) {
    SP500_datalist[[symbol]] <- stock_data
  }
}

save(SP500_datalist,SP500_symbols, file = "SP500.RData")
load("C:/Users/antho/文件/RMSC_R/Investmnet/Data/hsi_stock_data.RData")

