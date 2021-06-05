 dates={'11/12/2013';'11/13/2013'}
 higPrice=[100;100]
 lowPrice=[10;10]
 closePrice=[90;80]
 openPrice=[80;70]

 %construct a financial time series object
 tsobj = fints(datenum(dates,formatIn), [higPrice lowPrice closePrice openPrice], {'high','low','close','open'})  %put in correct order

 candle(tsobj);  %I get the plot