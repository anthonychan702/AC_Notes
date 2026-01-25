library(zoo)
library(quantmod)
library(dplyr)
# Until 2025-12
hsi_stock_codes = c(
  5, 388, 939, 1299, 1398, 2318, 2388, 2628, 3968, 3988,
  2, 3, 6, 836, 1038, 2688,
  12, 16, 101, 688, 823, 960, 1109, 1113, 1209, 1997,
  1, 27, 66, 175, 241, 267, 285, 288, 291, 300, 316, 322, 386, 669, 700, 728, 762, 857, 868, 881,
  883, 941, 968, 981, 992, 1024, 1044, 1088, 1093, 1099,
  1177, 1211, 1378, 1801, 1810, 1876, 1928, 1929, 2015, 2020,
  2057, 2269, 2313, 2319, 2331, 2359, 2382, 2618, 2899, 3690,
  3692, 6618, 6690, 6862, 9618, 9633, 9888, 9901, 9961, 9988,
  9992, 9999)

hsi_stock_symbol <- sapply(hsi_stock_codes,
function(x) paste0(strrep("0", 4-nchar(as.character(x))) , x , '.HK'))

hsi_stock_symbol = as.data.frame(hsi_stock_symbol)
rm(hsi_stock_codes)
hsi_stock_datalist = list()
start = '2019-01-01'
end = '2025-12-31'

for (symbol in hsi_stock_symbol) {
  stock_data <- getSymbols(symbol, from = start, to = end, auto.assign = FALSE)
  hsi_stock_datalist[[symbol]] <- stock_data  # store with symbol as list name
}

#save(hsi_stock_datalist,hsi_stock_symbol , file = "hsi_stock_data.RData")

# Verify , assume the all data contain 1721 trading days in 2019-2025
incompleted_componment = c()
for (stock in hsi_stock_datalist){
  # stock[record, features] , stock = hsi_stock_datalist[i]
  if(any(is.na(stock[,6]))){
    print(
      paste0("There existed missing value in " , names(stock[,6]))
    )
    incompleted_componment = c(substr(names(stock[,6]), 1, 7) ,incompleted_componment )
  }
  if(nrow(stock[,6])<1721){
    print(
      paste0("There existed missing date in " , names(stock[,6]))
    )
    incompleted_componment = c(substr(names(stock[,6]), 1, 7) ,incompleted_componment )
  }
}
incompleted_componment = unique(incompleted_componment)

completed_hsi_stock_datalist = 
  hsi_stock_datalist[!names(hsi_stock_datalist) %in% incompleted_componment]

save(hsi_stock_datalist,hsi_stock_symbol,completed_hsi_stock_datalist 
     , file = "hsi_stock_data.RData")
              