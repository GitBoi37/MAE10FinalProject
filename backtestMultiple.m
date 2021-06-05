
iAB = 0; %initial account balance in us dollars
sM = 50000; %share money, dollar value in stock of day one
pS = 5; %percent sell
pB = 20; %percent buy
SPYdata = importTicker('SPY');
a = SPYdata(:,2);
b = SPYdata(:,5);
profitSPY = backTestMABasic(a, b, iAB, sM, pS, pB);
NASDAQdata = importTicker('NASDAQ');
profitNASDAQ = backTestMABasic(NASDAQdata(:,2), NASDAQdata(:,5), iAB, sM, pS, pB);
GOLDdata = importTicker('GOLD');
profitGOLD = backTestMABasic(GOLDdata(:,2), GOLDdata(:,5), iAB, sM, pS, pB);
y = [profitSPY, profitNASDAQ, profitGOLD];
x = ["SPY traded", "SPY held", "NASDAQ traded", "NASDAQ held", "GOLD traded", "GOLD held"];
bar(y);
title('Profit comparison');
ylabel('Profit in US dollars')
set(gca, 'XTickLabel',x)
legend('Profit')
% 
% function x = getTickerCells(tickers)
%     x = emptycell
%     for i = 1:size(tickers,1)
        