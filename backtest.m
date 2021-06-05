clc;
%% initialize variables
initialAccBalance = 0; %keeps track of initial money in account
bal = initialAccBalance; %used to track free money in account in dollars
pS = 5; %percent sell, abbreviated this way because I'm lazy
pB = 20; %percent buy, ditto
shares = round(50000 / Open(1)); %50 thousnad dollars at the opening price of AAPL stock in shares, rounded to exclude fractional shares
dailyBal = bal * ones(size(Close,1),1); %7130x1 array of portfolio balance over range
%control balance, initialize to same as dailybal
control = dailyBal;  %7130x1 array will track the value of held stock (not sold) over range
dailyShares = zeros(size(Close,1),1); %7130x1 array of held shares over range
initShares = shares; %keeps track of initial shares in account
%buy sell array, keeps track of actions
bs = zeros(7130,1); %1 is sell, 0 is hold (default), -1 is buy for some reason
%TPV = total portfolio value, initialize to the value of portfolio at day one
%TPV = sum of market day value of balance in dollars and stock in dollars
TPV = (bal + shares * Open(1))*ones(size(Close,1),1);
x = binaryRecommendation(Open,Close);
%% run simulation, start at day 200 since thats what the moving average starts at
for i  = 200:size(Close,1)
    if(x(i) == 0 && x(i-1) == 1)
        %sell
        %bal  = current balance + the price of stock * the rounded whole
        %number of shares to sell (a percentage of the current number of
        %shares)
      
        bal = bal + Open(i) * round(shares * (pS / 100)); 
        shares = shares - round(shares * (pS / 100));
        bs(i) = 1;
    elseif(x(i) == 1 && x(i-1) == 0)
        %buy
        bs(i)= -1;
        bal = bal - round(bal * (pB / 100)); 
        shares = shares + round(bal * (pB / 100)/ Open(i));
    end
    dailyBal(i) = bal;
    dailyShares(i) = shares;
    control(i) = initShares * Open(i);
    TPV(i) = bal + shares * Open(i);
end
%calculate profit of bot trading
profitActive = bal + shares * Open(size(Close,1)) - initialAccBalance - initShares * Open(1);
%calculate profit of buying once at the beginning and holding until today
profitPassive = initShares * (Open(size(Close,1))) - initialAccBalance - initShares * Open(1);
%% do a lot of plotting
fprintf('Profit from trading: %.2f\n', profitActive);
fprintf('Profit from holding: %.2f\n', profitPassive);
%plotting scheme: 4 vertical panels 
%decided on this arranagement because it is easy to compare the dates
subplot(4,1,1);
%plot a graph of balance vs date
plot(Date, dailyBal);
title('Balance vs Date')
xlabel('Date')
ylabel('Balance $')
legend('Trading balance');    
%plot a discrete graph of buy sell recommendation
%1 is buy (will be on top) 
%0 is hold (middle)
%-1 is sell (on bottom)
subplot(4,1,2);
plot(Date, bs, 'x');
title('Buy Sell')
xlabel('Date')
ylabel('Reccomendation')
legend('1 = buy, 0 = hold, -1 = sell'); 
subplot(4,1,3);
%plot a function of the total shares held by the bot over the 
%course of the backtest
plot(Date, dailyShares);
title('Shares Over Time')
xlabel('Date')
ylabel('Number of shares')
legend('Shares'); 
subplot(4,1,4);
%plot a function of the total portfolio value 
%held by the bot over the course of the backtest
%TPV is sum of dollar amounts of all holdings so:
%TPV = stock price * number of stock + cash held
plot(Date, TPV);
title('Total Portfolio Value Over Time')
xlabel('Date')
ylabel('TPV ($)')
legend('Value in Dollars'); 
%legend('Trading balance', 'Value of control stock', 'Daily shares', 'Buy Sell');    